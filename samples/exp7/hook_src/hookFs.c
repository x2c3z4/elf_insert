#include "stdio.h"
#include "hookFs.h"
#include "ioLib.h"
#include "private/dosFsLibP.h"
#include "vxWorks.h"
#include "Assert.h"
#include "ftpLib.h"
#include<time.h> 

#define MAX_PNAME_LEN 1024
#define HOST_IP "192.168.106.131"
#define FTP_LOG_PATH "ftp0:X:/src/file-inotify/VxWorks_With_Inotify/inotify.log"

typedef struct PathNode
{
	char pName[MAX_PNAME_LEN];
	struct PathNode *next;
}PathNode;

PathNode *pHead;

#include "hostLib.h"
#include "netDrv.h"
int ftp_fd;

/*STATUS init_notify()
{
	pHead = (PathNode *)malloc(sizeof(PathNode));
	if(!pHead)
	{
		printf("NOTIFY INIT FAIL!\n");
		return(ERROR);
	}
	pHead->next = NULL;
	
	init_ftp();
	return(OK);
}


STATUS add_notify(char* pName)
{
	PathNode *pn = (PathNode *)malloc(sizeof(PathNode));
	char prefix[6];prefix[0]='h';prefix[1]='o';prefix[2]='o';prefix[3]='k';prefix[4]='_';prefix[5]='\0';
	if(!pn)
	{
 		printf("FAIL TO ALLOC MEM.\n");
 		return(ERROR);
	}
	if(!pHead)
	{
		free(pn);
 		printf("NOTIFY NOT INIT.\n");
 		return(ERROR);
	}
	memset(pn, 0, sizeof(PathNode));
	strcpy(pn->pName, prefix);
	strcat(pn->pName, pName);
	pn->next = pHead->next;
	pHead->next = pn;
	return(OK);
}


STATUS del_notify(char* pName)
{
	PathNode *pn1,*pn2;
	if(!pHead)
	{
 		printf("NOTIFY NOT INIT.\n");
 		return(ERROR);
	}
	pn1 = pHead;
	pn2 = pn1->next;
	while(pn2)
	{
		if(!strcmp(pn2->pName, pName))
		{
			pn1->next = pn2->next;
			free(pn2);
			return(OK);
		}
		pn1 = pn2;
		pn2 = pn1->next;
	}
	if(!pn2)
	{
 		printf("THE PATH HAS NOT ADDED TO NOTIFY.\n");
		return(ERROR);
	}
}

STATUS exit_notify()
{
	exit_ftp();
	while(pHead)
	{
		PathNode *pn = pHead;
		pHead = pHead->next;
		free(pn);
	}
 	printf("NOTIFY EXIT\n");
}

STATUS init_ftp()
{
	char ftpName[4];char devName[6];
	ftpName[0]='f';ftpName[1]='t';ftpName[2]='p';ftpName[3]='\0';
	devName[0]='f';devName[1]='t';devName[2]='p';devName[3]='0';devName[4]=':';devName[5]='\0';
	hostAdd(ftpName,HOST_IP);
	netDevCreate(devName,ftpName,1);
	ftp_fd = open(FTP_LOG_PATH, O_CREAT | O_WRONLY, 0644);
	lseek(ftp_fd, 0, SEEK_END);
	return(OK);
}

STATUS exit_ftp()
{
	close(ftp_fd);
	return(OK);
}

void ftp_write(char *str, int nBytes)
{
    int nWrite;
    nWrite = write (ftp_fd, str, nBytes);
     if(nWrite < 0)             
        printf("Ftp write error.\n"); 
}
*/

UINT32 read_ebp()
{
	UINT32 _ebp;
	__asm__ volatile("movl %%ebp, %0" : "=r"(_ebp));
	return _ebp;
}

int pathcmp(char str1[], const char *str2)
{
	int ret = 0;
	if(str1[strlen(str1) - 1] != '/')
	{
		str1[strlen(str1)] = '/';
		str1[strlen(str1) + 1] = '\0';
	}
	while(*str1 != '\0' && !(ret = *(unsigned char *)str1 - *(unsigned char *)str2))
	{
		str1++;
		str2++;
	}
	if(ret < 0) return -1;
	else if(ret > 0) return 1;
	return 0;
}

/* time_t biostime()   
 {
	struct tm ahora;
	unsigned char cHour, cMin, cSec; 
	unsigned char cDay, cMonth, cYear; 
  
	sysOutByte(0x70,0x00second); 
	cSec = sysInByte(0x71); 
	ahora.tm_sec = (cSec&0x0F) + 10*((cSec&0xF0)>>4); 
  
	sysOutByte(0x70,0x02minut); 
	cMin = sysInByte(0x71); 
	ahora.tm_min = (cMin&0x0F) + 10*((cMin&0xF0)>>4); 
  
	sysOutByte(0x70,0x04hour); 
	cHour = sysInByte(0x71); 
	ahora.tm_hour = (cHour&0x0F) + 10*((cHour&0xF0)>>4); 
  
	sysOutByte(0x70,0x07day); 
	cDay = sysInByte(0x71); 
	ahora.tm_mday = (cDay&0x0F) + 10*((cDay&0xF0)>>4); 
  
	sysOutByte(0x70,0x08month); 
	cMonth = sysInByte(0x71); 
	ahora.tm_mon = (cMonth&0x0F) + 10*((cMonth&0xF0)>>4) - 1; 
  
	sysOutByte(0x70,0x09year); 
	cYear = sysInByte(0x71); 
	ahora.tm_year = 100 + (cYear&0x0F) + 10*((cYear&0xF0)>>4); 
  
	return mktime(&ahora); 
}
*/

/*
void get_time(char datetime[])
{
	int res; 
	struct timespec ts; 
	struct tm daytime; 
	time_t stime; 
  
	ts.tv_sec = biostime(); 
	ts.tv_nsec = 0; 
	res = clock_settime(CLOCK_REALTIME, &ts); 
	
	stime = time(NULL); 

	daytime = *localtime(&stime);
	strcpy(datetime, asctime(&daytime));
}
*/

void traverse(PathNode *pn, char nameBuf[], char funName[])
{
	char _s[3];
	char _t[2];
	char _rn[3];
	
        _s[0]='%'; _s[1]='s';_s[2]='\0';
        
	_t[0]='\t';_t[1]='\0';
	_rn[0]='\r';_rn[1]='\n';_rn[2]='\0';
        
	while(pn)
		{
			/*	printf("name %s , pName %s\n", nameBuf, pn->pName); */\
			if(!strcmp(nameBuf, pn->pName) || !pathcmp(pn->pName, nameBuf))
			{
				char datetime[64];
				char result[MAX_PNAME_LEN + 80];
				memset(datetime, 0, sizeof(datetime));
				/*get_time(datetime);*/
				memset(result, 0, sizeof(result));
				strcpy(result,funName);
				strcat(result,_t);
				strcat(result,nameBuf);
				strcat(result,_t);
				strcat(result,datetime);
				strcat(result,_rn);
				/*ftp_write(result, strlen(result));*/
                                printf(_s,result);
				break;
			}
			pn = pn->next;
		}
}

void hook_dosFsOpen()
{
	UINT32 *_ebp;
	UINT32 arg;
	char nameBuf[MAX_PNAME_LEN];
	PathNode *pn;
	DOS_FILE_DESC_ID pfd;
	if(!pHead)
	{
		printf("NOTIFY NOT INIT.\n");
		return;
	}
	pn = pHead->next;
	if(!pn)
		return;
	memset(nameBuf, 0, sizeof(nameBuf));
	_ebp = (UINT32 *) read_ebp();
	_ebp = _ebp[0];
	/* arg0 = _ebp[2];\
	arg1 = _ebp[3];\
	arg2 = _ebp[4];\
	arg3 = _ebp[5];\
	arg4 = _ebp[6];*/
	
	arg = _ebp[4];
	/*printf("%s : %s\n", #name, arg); */\
	strcpy(nameBuf, arg);
	/*printf("nameBuf: %s\n",nameBuf); */\
	
	
	/* printf("%s ebp: %08x, args: %08x, %08x, %08x, %08x, %08x\n", #name, _ebp, arg0, arg1, arg2, arg3, arg4); */\
	traverse(pn, nameBuf, __FUNCTION__);
}

void hook_dosFsCreate()
{
	UINT32 *_ebp;
	UINT32 arg;
	char nameBuf[MAX_PNAME_LEN];
	PathNode *pn;
	DOS_FILE_DESC_ID pfd;
	if(!pHead)
	{
		/*printf("NOTIFY NOT INIT.\n");*/
		return;
	}
	pn = pHead->next;
	if(!pn)
		return;
	memset(nameBuf, 0, sizeof(nameBuf));
	_ebp = (UINT32 *) read_ebp();
	_ebp = _ebp[0];
	/* arg0 = _ebp[2];\
	arg1 = _ebp[3];\
	arg2 = _ebp[4];\
	arg3 = _ebp[5];\
	arg4 = _ebp[6];*/\
	
	arg = _ebp[4];
	/*printf("%s : %s\n", #name, arg); */\
	strcpy(nameBuf, arg);
	/*printf("nameBuf: %s\n",nameBuf); */\
	
	/* printf("%s ebp: %08x, args: %08x, %08x, %08x, %08x, %08x\n", #name, _ebp, arg0, arg1, arg2, arg3, arg4); */\
	traverse(pn, nameBuf, __FUNCTION__);
}

void hook_dosFsRead()
{
	UINT32 *_ebp;
	UINT32 arg;
	char nameBuf[MAX_PNAME_LEN];
	PathNode *pn;
	DOS_FILE_DESC_ID pfd;
	if(!pHead)
	{
		/*printf("NOTIFY NOT INIT.\n");*/
		return;
	}
	pn = pHead->next;
	if(!pn)
		return;
	memset(nameBuf, 0, sizeof(nameBuf));
	_ebp = (UINT32 *) read_ebp();
	_ebp = _ebp[0];
	/* arg0 = _ebp[2];\
	arg1 = _ebp[3];\
	arg2 = _ebp[4];\
	arg3 = _ebp[5];\
	arg4 = _ebp[6];*/\
	
	/* Get the pFd */
	_ebp = (UINT32 *) read_ebp();
	/*arg0 = _ebp[2];\
	arg1 = _ebp[3];\
	arg2 = _ebp[4];\
	arg3 = _ebp[5];\
	arg4 = _ebp[6];*/\
	arg = _ebp[2];
	pfd = (DOS_FILE_DESC_ID)arg;
	dosChkBuildPath(pfd);
	/*	printf("name : %s\n", pfd->pVolDesc->pChkDesc->chkPath); */\
	strcpy(nameBuf, pfd->pVolDesc->pChkDesc->chkPath);	
	
	/* printf("%s ebp: %08x, args: %08x, %08x, %08x, %08x, %08x\n", #name, _ebp, arg0, arg1, arg2, arg3, arg4); */\
	traverse(pn, nameBuf, __FUNCTION__);
}

void hook_dosFsWrite()
{
	UINT32 *_ebp;
	UINT32 arg;
	char nameBuf[MAX_PNAME_LEN];
	PathNode *pn;
	DOS_FILE_DESC_ID pfd;
	if(!pHead)
	{
		/*printf("NOTIFY NOT INIT.\n");*/
		return;
	}
	pn = pHead->next;
	if(!pn)
		return;
	memset(nameBuf, 0, sizeof(nameBuf));
	_ebp = (UINT32 *) read_ebp();
	_ebp = _ebp[0];
	/* arg0 = _ebp[2];\
	arg1 = _ebp[3];\
	arg2 = _ebp[4];\
	arg3 = _ebp[5];\
	arg4 = _ebp[6];*/\
	
	/* Get the pFd */
	_ebp = (UINT32 *) read_ebp();
	/*arg0 = _ebp[2];\
	arg1 = _ebp[3];\
	arg2 = _ebp[4];\
	arg3 = _ebp[5];\
	arg4 = _ebp[6];*/\
	arg = _ebp[2];
	pfd = (DOS_FILE_DESC_ID)arg;
	dosChkBuildPath(pfd);
	/*	printf("name : %s\n", pfd->pVolDesc->pChkDesc->chkPath); */\
	strcpy(nameBuf, pfd->pVolDesc->pChkDesc->chkPath);	
	
	/* printf("%s ebp: %08x, args: %08x, %08x, %08x, %08x, %08x\n", #name, _ebp, arg0, arg1, arg2, arg3, arg4); */\
	traverse(pn, nameBuf, __FUNCTION__);
}

void hook_dosFsClose()
{
	UINT32 *_ebp;
	UINT32 arg;
	char nameBuf[MAX_PNAME_LEN];
	PathNode *pn;
	DOS_FILE_DESC_ID pfd;
	if(!pHead)
	{
		/*printf("NOTIFY NOT INIT.\n");*/
		return;
	}
	pn = pHead->next;
	if(!pn)
		return;
	memset(nameBuf, 0, sizeof(nameBuf));
	_ebp = (UINT32 *) read_ebp();
	_ebp = _ebp[0];
	/* arg0 = _ebp[2];\
	arg1 = _ebp[3];\
	arg2 = _ebp[4];\
	arg3 = _ebp[5];\
	arg4 = _ebp[6];*/\
	
	arg = _ebp[2];
	pfd = (DOS_FILE_DESC_ID)arg;
	dosChkBuildPath(pfd);
	/*	printf("name : %s\n", pfd->pVolDesc->pChkDesc->chkPath); */\
	strcpy(nameBuf, pfd->pVolDesc->pChkDesc->chkPath);
	
	/* printf("%s ebp: %08x, args: %08x, %08x, %08x, %08x, %08x\n", #name, _ebp, arg0, arg1, arg2, arg3, arg4); */\
	traverse(pn, nameBuf, __FUNCTION__);
}

void hook_dosFsDelete()
{
	UINT32 *_ebp;
	UINT32 arg;
	char nameBuf[MAX_PNAME_LEN];
	PathNode *pn;
	DOS_FILE_DESC_ID pfd;
	if(!pHead)
	{
		/*printf("NOTIFY NOT INIT.\n");*/
		return;
	}
	pn = pHead->next;
	if(!pn)
		return;
	memset(nameBuf, 0, sizeof(nameBuf));
	_ebp = (UINT32 *) read_ebp();
	_ebp = _ebp[0];
	/* arg0 = _ebp[2];\
	arg1 = _ebp[3];\
	arg2 = _ebp[4];\
	arg3 = _ebp[5];\
	arg4 = _ebp[6];*/\
	
	_ebp = (UINT32 *) read_ebp();
	arg = _ebp[2];\
	/*printf("%s : %s\n", #name, arg); */\
	strcpy(nameBuf, arg);
	
	/* printf("%s ebp: %08x, args: %08x, %08x, %08x, %08x, %08x\n", #name, _ebp, arg0, arg1, arg2, arg3, arg4); */\
	traverse(pn, nameBuf, __FUNCTION__);
}
