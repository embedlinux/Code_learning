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


volatile unsigned long *gpfcon = NULL;
volatile unsigned long *gpfdat = NULL;

static struct class *buttondrv_class;
static struct class_device	*buttondrv_class_dev;

static int leddrv_open(struct inode *inode, struct file *file)
{
//	printk("open the file...\n");
	*gpfcon &= ~((0x3<<(0*2)) | (0x3<<(1*2)) | (0x3<<(2*2))) | (0x3<<(4*2));

	return 0;
}

ssize_t leddrv_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
{
//	printk("read the button status...\n");
	unsigned char key_vals[4] = {1};
	int regval = 0;

	if(size != sizeof(key_vals))
		return -EINVAL;

	regval = *gpfdat;

	key_vals[0] = (regval & (1<<0)) ? 1 : 0;
	key_vals[1] = (regval & (1<<1)) ? 1 : 0;
	key_vals[2] = (regval & (1<<2)) ? 1 : 0;
	key_vals[3] = (regval & (1<<4)) ? 1 : 0;

	copy_to_user(buf, key_vals, sizeof(key_vals));

	return sizeof(key_vals);
}

static struct file_operations buttondrv_fops = {
    .owner  =   THIS_MODULE,         /* 这是一个宏，推向编译模块时自动创建的__this_module变量 */
    .open   =   leddrv_open,     
	.read	=	leddrv_read,	   
};

int major;
static int button_drv_init(void)
{
	printk("init  driver...\n");
	major = register_chrdev(0, "button_drv", &buttondrv_fops); // 注册, 告诉内核

	buttondrv_class = (struct class *)class_create(THIS_MODULE, "button_drv");
	buttondrv_class_dev = (struct class_device	*)class_device_create(buttondrv_class, NULL, MKDEV(major, 0), NULL, "buttons"); /* /dev/xyz */

	gpfcon = (volatile unsigned long *)ioremap(0x56000050, 16);   //映射
	gpfdat = gpfcon + 1;

	return 0;
}

static void button_drv_exit(void)
{
	printk("exit  driver...\n");
	unregister_chrdev(major, "button_drv");                    // 卸载
	class_device_unregister(buttondrv_class_dev);
	class_destroy(buttondrv_class);

	iounmap(gpfcon);
}

module_init(button_drv_init);
module_exit(button_drv_exit);
MODULE_LICENSE("GPL");
