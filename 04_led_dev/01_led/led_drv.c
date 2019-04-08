#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/fs.h>
#include <linux/init.h>
#include <linux/delay.h>
#include <asm/uaccess.h>
#include <asm/irq.h>
#include <asm/io.h>
#include <asm/arch/regs-gpio.h>
#include <asm/hardware.h>


static struct class *leddrv_class;
static struct class_device	*leddrv_class_dev;

volatile unsigned long *gpbcon = NULL;
volatile unsigned long *gpbdat = NULL;


static int leddrv_open(struct inode *inode, struct file *file)
{
//	printk("open the file...\n");
	*gpbcon &= ~((0x3<<10) | (0x3<<12) | (0x3<<14) | (0x3<<16));

	*gpbcon |= ((0x1<<10) | (0x1<<12) | (0x1<<14) | (0x1<<16));

	return 0;
}

	
static int leddrv_write(struct file *file, const char *buf, unsigned long count, void *data)
{
	//printk("write the file...\n");
	int val = 0;
	copy_from_user(&val, buf, count);

	if(val == 1)   //灭灯
	{
		*gpbdat |= ((0x1<<5)|(0x1<<6)|(0x1<<7)|(0x1<<8));
	}
	else
	{
		*gpbdat &= ~((0x1<<5)|(0x1<<6)|(0x1<<7)|(0x1<<8));
	}
	return 0;
}


static struct file_operations leddrv_fops = {
    .owner  =   THIS_MODULE,         /* 这是一个宏，推向编译模块时自动创建的__this_module变量 */
    .open   =   leddrv_open,     
	.write	=	leddrv_write,	   
};


int major;
static int led_drv_init(void)
{
	printk("init led driver...\n");
	major = register_chrdev(0, "led_drv", &leddrv_fops); // 注册, 告诉内核

	leddrv_class = class_create(THIS_MODULE, "led_drv");
	leddrv_class_dev = class_device_create(leddrv_class, NULL, MKDEV(major, 0), NULL, "led"); /* /dev/led */

	gpbcon = (volatile unsigned long *)ioremap(0x56000010, 16);   //映射
	gpbdat = gpbcon + 1;

	*gpbdat |= ((0x1<<5)|(0x1<<6)|(0x1<<7)|(0x1<<8));     //初始情况灯全灭
	return 0;
}

static void led_drv_exit(void)
{
	printk("exit led driver...\n");
	unregister_chrdev(major, "led_drv");                    // 卸载
	class_device_unregister(leddrv_class_dev);
	class_destroy(leddrv_class);

	iounmap(gpbcon);
}

module_init(led_drv_init);
module_exit(led_drv_exit);
MODULE_LICENSE("GPL");
