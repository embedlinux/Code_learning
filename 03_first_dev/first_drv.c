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


static struct class *firstdrv_class;
static struct class_device	*firstdrv_class_dev;


static int firstdrv_open(void)
{
	printk("open the file...\n");
	return 0;
}




static void firstdrv_write(void)
{
	printk("write the file...\n");
}


static struct file_operations firstdrv_fops = {
    .owner  =   THIS_MODULE,         /* 这是一个宏，推向编译模块时自动创建的__this_module变量 */
    .open   =   firstdrv_open,     
	.write	=	firstdrv_write,	   
};


int major;
static int first_drv_init(void)
{
	printk("init first driver...\n");
	major = register_chrdev(0, "first_drv", &firstdrv_fops); // 注册, 告诉内核

	firstdrv_class = class_create(THIS_MODULE, "firstdrv");
	firstdrv_class_dev = class_device_create(firstdrv_class, NULL, MKDEV(major, 0), NULL, "xyz"); /* /dev/xyz */

	return 0;
}

static void first_drv_exit(void)
{
	printk("exit first driver...\n");
	unregister_chrdev(major, "first_drv");                    // 卸载
	class_device_unregister(firstdrv_class_dev);
	class_destroy(firstdrv_class);
}



module_init(first_drv_init);
module_exit(first_drv_exit);
MODULE_LICENSE("GPL");