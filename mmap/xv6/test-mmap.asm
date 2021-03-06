
_test-mmap:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(void)
{
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	56                   	push   %esi
  12:	53                   	push   %ebx
  13:	51                   	push   %ecx
  14:	83 ec 0c             	sub    $0xc,%esp
  uint ret;
  printf(1, "Start: memory usage in pages: virtual: %d, physical %d\n", numvp(), numpp());
  17:	e8 7f 04 00 00       	call   49b <numpp>
  1c:	89 c3                	mov    %eax,%ebx
  1e:	e8 70 04 00 00       	call   493 <numvp>
  23:	53                   	push   %ebx
  24:	50                   	push   %eax
  25:	68 c8 08 00 00       	push   $0x8c8
  2a:	6a 01                	push   $0x1
  2c:	e8 2f 05 00 00       	call   560 <printf>

  ret = mmap (-1234);
  31:	c7 04 24 2e fb ff ff 	movl   $0xfffffb2e,(%esp)
  38:	e8 66 04 00 00       	call   4a3 <mmap>
  if(ret == 0)
  3d:	83 c4 10             	add    $0x10,%esp
  40:	85 c0                	test   %eax,%eax
  42:	0f 85 b0 00 00 00    	jne    f8 <main+0xf8>
    printf(1, "mmap failed for wrong inputs\n");
  48:	53                   	push   %ebx
  49:	53                   	push   %ebx
  4a:	68 7a 0a 00 00       	push   $0xa7a
  4f:	6a 01                	push   $0x1
  51:	e8 0a 05 00 00       	call   560 <printf>
  else
    exit();
  
  ret = mmap (1234);
  56:	c7 04 24 d2 04 00 00 	movl   $0x4d2,(%esp)
  5d:	e8 41 04 00 00       	call   4a3 <mmap>
  if(ret == 0)
  62:	83 c4 10             	add    $0x10,%esp
  65:	85 c0                	test   %eax,%eax
  67:	0f 85 8b 00 00 00    	jne    f8 <main+0xf8>
    printf(1, "mmap failed for wrong inputs\n");
  6d:	51                   	push   %ecx
  6e:	51                   	push   %ecx
  6f:	68 7a 0a 00 00       	push   $0xa7a
  74:	6a 01                	push   $0x1
  76:	e8 e5 04 00 00       	call   560 <printf>
  else
    exit();

  
  ret = mmap(4096);
  7b:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
  82:	e8 1c 04 00 00       	call   4a3 <mmap>
  
  if(ret == 0 )
  87:	83 c4 10             	add    $0x10,%esp
  ret = mmap(4096);
  8a:	89 c3                	mov    %eax,%ebx
  if(ret == 0 )
  8c:	85 c0                	test   %eax,%eax
  8e:	74 6d                	je     fd <main+0xfd>
    printf(1, "mmap failed\n");
  else {
    printf(1, "After mmap one page: memory usage in pages: virtual: %d, physical %d\n", numvp(), numpp());
  90:	e8 06 04 00 00       	call   49b <numpp>
  95:	89 c6                	mov    %eax,%esi
  97:	e8 f7 03 00 00       	call   493 <numvp>
  9c:	56                   	push   %esi
  9d:	50                   	push   %eax
  9e:	68 00 09 00 00       	push   $0x900
  a3:	6a 01                	push   $0x1
  a5:	e8 b6 04 00 00       	call   560 <printf>

    char *addr = (char *) ret;

    addr[0] = 'a';
  aa:	c6 03 61             	movb   $0x61,(%ebx)
    
    printf(1, "After access of one page: memory usage in pages: virtual: %d, physical %d\n", numvp(), numpp());
  ad:	e8 e9 03 00 00       	call   49b <numpp>
  b2:	89 c3                	mov    %eax,%ebx
  b4:	e8 da 03 00 00       	call   493 <numvp>
  b9:	53                   	push   %ebx
  ba:	50                   	push   %eax
  bb:	68 48 09 00 00       	push   $0x948
  c0:	6a 01                	push   $0x1
  c2:	e8 99 04 00 00       	call   560 <printf>
  c7:	83 c4 20             	add    $0x20,%esp
  }

  ret = mmap(8192);
  ca:	83 ec 0c             	sub    $0xc,%esp
  cd:	68 00 20 00 00       	push   $0x2000
  d2:	e8 cc 03 00 00       	call   4a3 <mmap>

  if(ret == 0 )
  d7:	83 c4 10             	add    $0x10,%esp
  ret = mmap(8192);
  da:	89 c3                	mov    %eax,%ebx
  if(ret == 0 )
  dc:	85 c0                	test   %eax,%eax
  de:	75 30                	jne    110 <main+0x110>
    printf(1, "mmap failed\n");
  e0:	50                   	push   %eax
  e1:	50                   	push   %eax
  e2:	68 98 0a 00 00       	push   $0xa98
  e7:	6a 01                	push   $0x1
  e9:	e8 72 04 00 00       	call   560 <printf>
  ee:	83 c4 10             	add    $0x10,%esp
  f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
  f8:	e8 d6 02 00 00       	call   3d3 <exit>
    printf(1, "mmap failed\n");
  fd:	52                   	push   %edx
  fe:	52                   	push   %edx
  ff:	68 98 0a 00 00       	push   $0xa98
 104:	6a 01                	push   $0x1
 106:	e8 55 04 00 00       	call   560 <printf>
 10b:	83 c4 10             	add    $0x10,%esp
 10e:	eb ba                	jmp    ca <main+0xca>
  else {
    printf(1, "After mmap two pages: memory usage in pages: virtual: %d, physical %d\n", numvp(), numpp());
 110:	e8 86 03 00 00       	call   49b <numpp>
 115:	89 c6                	mov    %eax,%esi
 117:	e8 77 03 00 00       	call   493 <numvp>
 11c:	56                   	push   %esi
 11d:	50                   	push   %eax
 11e:	68 94 09 00 00       	push   $0x994
 123:	6a 01                	push   $0x1
 125:	e8 36 04 00 00       	call   560 <printf>

    char *addr = (char *) ret;

    addr[0] = 'a';
 12a:	c6 03 61             	movb   $0x61,(%ebx)
    
    printf(1, "After access of first page: memory usage in pages: virtual: %d, physical %d\n", numvp(), numpp());
 12d:	e8 69 03 00 00       	call   49b <numpp>
 132:	89 c6                	mov    %eax,%esi
 134:	e8 5a 03 00 00       	call   493 <numvp>
 139:	56                   	push   %esi
 13a:	50                   	push   %eax
 13b:	68 dc 09 00 00       	push   $0x9dc
 140:	6a 01                	push   $0x1
 142:	e8 19 04 00 00       	call   560 <printf>
    addr[8000] = 'a';
 147:	c6 83 40 1f 00 00 61 	movb   $0x61,0x1f40(%ebx)

    printf(1, "After access of second page: memory usage in pages: virtual: %d, physical %d\n", numvp(), numpp());
 14e:	83 c4 20             	add    $0x20,%esp
 151:	e8 45 03 00 00       	call   49b <numpp>
 156:	89 c3                	mov    %eax,%ebx
 158:	e8 36 03 00 00       	call   493 <numvp>
 15d:	53                   	push   %ebx
 15e:	50                   	push   %eax
 15f:	68 2c 0a 00 00       	push   $0xa2c
 164:	6a 01                	push   $0x1
 166:	e8 f5 03 00 00       	call   560 <printf>
 16b:	83 c4 10             	add    $0x10,%esp
 16e:	eb 88                	jmp    f8 <main+0xf8>

00000170 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 170:	f3 0f 1e fb          	endbr32 
 174:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 175:	31 c0                	xor    %eax,%eax
{
 177:	89 e5                	mov    %esp,%ebp
 179:	53                   	push   %ebx
 17a:	8b 4d 08             	mov    0x8(%ebp),%ecx
 17d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while((*s++ = *t++) != 0)
 180:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 184:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 187:	83 c0 01             	add    $0x1,%eax
 18a:	84 d2                	test   %dl,%dl
 18c:	75 f2                	jne    180 <strcpy+0x10>
    ;
  return os;
}
 18e:	89 c8                	mov    %ecx,%eax
 190:	5b                   	pop    %ebx
 191:	5d                   	pop    %ebp
 192:	c3                   	ret    
 193:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 19a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1a0:	f3 0f 1e fb          	endbr32 
 1a4:	55                   	push   %ebp
 1a5:	89 e5                	mov    %esp,%ebp
 1a7:	53                   	push   %ebx
 1a8:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1ab:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 1ae:	0f b6 01             	movzbl (%ecx),%eax
 1b1:	0f b6 1a             	movzbl (%edx),%ebx
 1b4:	84 c0                	test   %al,%al
 1b6:	75 19                	jne    1d1 <strcmp+0x31>
 1b8:	eb 26                	jmp    1e0 <strcmp+0x40>
 1ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1c0:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 1c4:	83 c1 01             	add    $0x1,%ecx
 1c7:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 1ca:	0f b6 1a             	movzbl (%edx),%ebx
 1cd:	84 c0                	test   %al,%al
 1cf:	74 0f                	je     1e0 <strcmp+0x40>
 1d1:	38 d8                	cmp    %bl,%al
 1d3:	74 eb                	je     1c0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 1d5:	29 d8                	sub    %ebx,%eax
}
 1d7:	5b                   	pop    %ebx
 1d8:	5d                   	pop    %ebp
 1d9:	c3                   	ret    
 1da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1e0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 1e2:	29 d8                	sub    %ebx,%eax
}
 1e4:	5b                   	pop    %ebx
 1e5:	5d                   	pop    %ebp
 1e6:	c3                   	ret    
 1e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ee:	66 90                	xchg   %ax,%ax

000001f0 <strlen>:

uint
strlen(const char *s)
{
 1f0:	f3 0f 1e fb          	endbr32 
 1f4:	55                   	push   %ebp
 1f5:	89 e5                	mov    %esp,%ebp
 1f7:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 1fa:	80 3a 00             	cmpb   $0x0,(%edx)
 1fd:	74 21                	je     220 <strlen+0x30>
 1ff:	31 c0                	xor    %eax,%eax
 201:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 208:	83 c0 01             	add    $0x1,%eax
 20b:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 20f:	89 c1                	mov    %eax,%ecx
 211:	75 f5                	jne    208 <strlen+0x18>
    ;
  return n;
}
 213:	89 c8                	mov    %ecx,%eax
 215:	5d                   	pop    %ebp
 216:	c3                   	ret    
 217:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 21e:	66 90                	xchg   %ax,%ax
  for(n = 0; s[n]; n++)
 220:	31 c9                	xor    %ecx,%ecx
}
 222:	5d                   	pop    %ebp
 223:	89 c8                	mov    %ecx,%eax
 225:	c3                   	ret    
 226:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 22d:	8d 76 00             	lea    0x0(%esi),%esi

00000230 <memset>:

void*
memset(void *dst, int c, uint n)
{
 230:	f3 0f 1e fb          	endbr32 
 234:	55                   	push   %ebp
 235:	89 e5                	mov    %esp,%ebp
 237:	57                   	push   %edi
 238:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 23b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 23e:	8b 45 0c             	mov    0xc(%ebp),%eax
 241:	89 d7                	mov    %edx,%edi
 243:	fc                   	cld    
 244:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 246:	89 d0                	mov    %edx,%eax
 248:	5f                   	pop    %edi
 249:	5d                   	pop    %ebp
 24a:	c3                   	ret    
 24b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 24f:	90                   	nop

00000250 <strchr>:

char*
strchr(const char *s, char c)
{
 250:	f3 0f 1e fb          	endbr32 
 254:	55                   	push   %ebp
 255:	89 e5                	mov    %esp,%ebp
 257:	8b 45 08             	mov    0x8(%ebp),%eax
 25a:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 25e:	0f b6 10             	movzbl (%eax),%edx
 261:	84 d2                	test   %dl,%dl
 263:	75 16                	jne    27b <strchr+0x2b>
 265:	eb 21                	jmp    288 <strchr+0x38>
 267:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 26e:	66 90                	xchg   %ax,%ax
 270:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 274:	83 c0 01             	add    $0x1,%eax
 277:	84 d2                	test   %dl,%dl
 279:	74 0d                	je     288 <strchr+0x38>
    if(*s == c)
 27b:	38 d1                	cmp    %dl,%cl
 27d:	75 f1                	jne    270 <strchr+0x20>
      return (char*)s;
  return 0;
}
 27f:	5d                   	pop    %ebp
 280:	c3                   	ret    
 281:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 288:	31 c0                	xor    %eax,%eax
}
 28a:	5d                   	pop    %ebp
 28b:	c3                   	ret    
 28c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000290 <gets>:

char*
gets(char *buf, int max)
{
 290:	f3 0f 1e fb          	endbr32 
 294:	55                   	push   %ebp
 295:	89 e5                	mov    %esp,%ebp
 297:	57                   	push   %edi
 298:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 299:	31 f6                	xor    %esi,%esi
{
 29b:	53                   	push   %ebx
 29c:	89 f3                	mov    %esi,%ebx
 29e:	83 ec 1c             	sub    $0x1c,%esp
 2a1:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 2a4:	eb 33                	jmp    2d9 <gets+0x49>
 2a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2ad:	8d 76 00             	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 2b0:	83 ec 04             	sub    $0x4,%esp
 2b3:	8d 45 e7             	lea    -0x19(%ebp),%eax
 2b6:	6a 01                	push   $0x1
 2b8:	50                   	push   %eax
 2b9:	6a 00                	push   $0x0
 2bb:	e8 2b 01 00 00       	call   3eb <read>
    if(cc < 1)
 2c0:	83 c4 10             	add    $0x10,%esp
 2c3:	85 c0                	test   %eax,%eax
 2c5:	7e 1c                	jle    2e3 <gets+0x53>
      break;
    buf[i++] = c;
 2c7:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2cb:	83 c7 01             	add    $0x1,%edi
 2ce:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 2d1:	3c 0a                	cmp    $0xa,%al
 2d3:	74 23                	je     2f8 <gets+0x68>
 2d5:	3c 0d                	cmp    $0xd,%al
 2d7:	74 1f                	je     2f8 <gets+0x68>
  for(i=0; i+1 < max; ){
 2d9:	83 c3 01             	add    $0x1,%ebx
 2dc:	89 fe                	mov    %edi,%esi
 2de:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2e1:	7c cd                	jl     2b0 <gets+0x20>
 2e3:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 2e5:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 2e8:	c6 03 00             	movb   $0x0,(%ebx)
}
 2eb:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2ee:	5b                   	pop    %ebx
 2ef:	5e                   	pop    %esi
 2f0:	5f                   	pop    %edi
 2f1:	5d                   	pop    %ebp
 2f2:	c3                   	ret    
 2f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2f7:	90                   	nop
 2f8:	8b 75 08             	mov    0x8(%ebp),%esi
 2fb:	8b 45 08             	mov    0x8(%ebp),%eax
 2fe:	01 de                	add    %ebx,%esi
 300:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 302:	c6 03 00             	movb   $0x0,(%ebx)
}
 305:	8d 65 f4             	lea    -0xc(%ebp),%esp
 308:	5b                   	pop    %ebx
 309:	5e                   	pop    %esi
 30a:	5f                   	pop    %edi
 30b:	5d                   	pop    %ebp
 30c:	c3                   	ret    
 30d:	8d 76 00             	lea    0x0(%esi),%esi

00000310 <stat>:

int
stat(const char *n, struct stat *st)
{
 310:	f3 0f 1e fb          	endbr32 
 314:	55                   	push   %ebp
 315:	89 e5                	mov    %esp,%ebp
 317:	56                   	push   %esi
 318:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 319:	83 ec 08             	sub    $0x8,%esp
 31c:	6a 00                	push   $0x0
 31e:	ff 75 08             	pushl  0x8(%ebp)
 321:	e8 ed 00 00 00       	call   413 <open>
  if(fd < 0)
 326:	83 c4 10             	add    $0x10,%esp
 329:	85 c0                	test   %eax,%eax
 32b:	78 2b                	js     358 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 32d:	83 ec 08             	sub    $0x8,%esp
 330:	ff 75 0c             	pushl  0xc(%ebp)
 333:	89 c3                	mov    %eax,%ebx
 335:	50                   	push   %eax
 336:	e8 f0 00 00 00       	call   42b <fstat>
  close(fd);
 33b:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 33e:	89 c6                	mov    %eax,%esi
  close(fd);
 340:	e8 b6 00 00 00       	call   3fb <close>
  return r;
 345:	83 c4 10             	add    $0x10,%esp
}
 348:	8d 65 f8             	lea    -0x8(%ebp),%esp
 34b:	89 f0                	mov    %esi,%eax
 34d:	5b                   	pop    %ebx
 34e:	5e                   	pop    %esi
 34f:	5d                   	pop    %ebp
 350:	c3                   	ret    
 351:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 358:	be ff ff ff ff       	mov    $0xffffffff,%esi
 35d:	eb e9                	jmp    348 <stat+0x38>
 35f:	90                   	nop

00000360 <atoi>:

int
atoi(const char *s)
{
 360:	f3 0f 1e fb          	endbr32 
 364:	55                   	push   %ebp
 365:	89 e5                	mov    %esp,%ebp
 367:	53                   	push   %ebx
 368:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 36b:	0f be 02             	movsbl (%edx),%eax
 36e:	8d 48 d0             	lea    -0x30(%eax),%ecx
 371:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 374:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 379:	77 1a                	ja     395 <atoi+0x35>
 37b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 37f:	90                   	nop
    n = n*10 + *s++ - '0';
 380:	83 c2 01             	add    $0x1,%edx
 383:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 386:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 38a:	0f be 02             	movsbl (%edx),%eax
 38d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 390:	80 fb 09             	cmp    $0x9,%bl
 393:	76 eb                	jbe    380 <atoi+0x20>
  return n;
}
 395:	89 c8                	mov    %ecx,%eax
 397:	5b                   	pop    %ebx
 398:	5d                   	pop    %ebp
 399:	c3                   	ret    
 39a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003a0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3a0:	f3 0f 1e fb          	endbr32 
 3a4:	55                   	push   %ebp
 3a5:	89 e5                	mov    %esp,%ebp
 3a7:	57                   	push   %edi
 3a8:	8b 45 10             	mov    0x10(%ebp),%eax
 3ab:	8b 55 08             	mov    0x8(%ebp),%edx
 3ae:	56                   	push   %esi
 3af:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3b2:	85 c0                	test   %eax,%eax
 3b4:	7e 0f                	jle    3c5 <memmove+0x25>
 3b6:	01 d0                	add    %edx,%eax
  dst = vdst;
 3b8:	89 d7                	mov    %edx,%edi
 3ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *dst++ = *src++;
 3c0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 3c1:	39 f8                	cmp    %edi,%eax
 3c3:	75 fb                	jne    3c0 <memmove+0x20>
  return vdst;
}
 3c5:	5e                   	pop    %esi
 3c6:	89 d0                	mov    %edx,%eax
 3c8:	5f                   	pop    %edi
 3c9:	5d                   	pop    %ebp
 3ca:	c3                   	ret    

000003cb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3cb:	b8 01 00 00 00       	mov    $0x1,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    

000003d3 <exit>:
SYSCALL(exit)
 3d3:	b8 02 00 00 00       	mov    $0x2,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    

000003db <wait>:
SYSCALL(wait)
 3db:	b8 03 00 00 00       	mov    $0x3,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <pipe>:
SYSCALL(pipe)
 3e3:	b8 04 00 00 00       	mov    $0x4,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <read>:
SYSCALL(read)
 3eb:	b8 05 00 00 00       	mov    $0x5,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <write>:
SYSCALL(write)
 3f3:	b8 10 00 00 00       	mov    $0x10,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <close>:
SYSCALL(close)
 3fb:	b8 15 00 00 00       	mov    $0x15,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    

00000403 <kill>:
SYSCALL(kill)
 403:	b8 06 00 00 00       	mov    $0x6,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret    

0000040b <exec>:
SYSCALL(exec)
 40b:	b8 07 00 00 00       	mov    $0x7,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret    

00000413 <open>:
SYSCALL(open)
 413:	b8 0f 00 00 00       	mov    $0xf,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret    

0000041b <mknod>:
SYSCALL(mknod)
 41b:	b8 11 00 00 00       	mov    $0x11,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret    

00000423 <unlink>:
SYSCALL(unlink)
 423:	b8 12 00 00 00       	mov    $0x12,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret    

0000042b <fstat>:
SYSCALL(fstat)
 42b:	b8 08 00 00 00       	mov    $0x8,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret    

00000433 <link>:
SYSCALL(link)
 433:	b8 13 00 00 00       	mov    $0x13,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret    

0000043b <mkdir>:
SYSCALL(mkdir)
 43b:	b8 14 00 00 00       	mov    $0x14,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret    

00000443 <chdir>:
SYSCALL(chdir)
 443:	b8 09 00 00 00       	mov    $0x9,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret    

0000044b <dup>:
SYSCALL(dup)
 44b:	b8 0a 00 00 00       	mov    $0xa,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret    

00000453 <getpid>:
SYSCALL(getpid)
 453:	b8 0b 00 00 00       	mov    $0xb,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret    

0000045b <sbrk>:
SYSCALL(sbrk)
 45b:	b8 0c 00 00 00       	mov    $0xc,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret    

00000463 <sleep>:
SYSCALL(sleep)
 463:	b8 0d 00 00 00       	mov    $0xd,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret    

0000046b <uptime>:
SYSCALL(uptime)
 46b:	b8 0e 00 00 00       	mov    $0xe,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret    

00000473 <hello>:
//-------------
// Source code files - these interface user program to invoke system call
// Basically, grants permissions to specific user functions to invoke system calls
// PA1
SYSCALL(hello)
 473:	b8 16 00 00 00       	mov    $0x16,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret    

0000047b <helloYou>:
SYSCALL(helloYou)
 47b:	b8 17 00 00 00       	mov    $0x17,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret    

00000483 <getNumProc>:
SYSCALL(getNumProc)
 483:	b8 18 00 00 00       	mov    $0x18,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret    

0000048b <showAncestry>:
SYSCALL(showAncestry)
 48b:	b8 19 00 00 00       	mov    $0x19,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret    

00000493 <numvp>:
//PA2
SYSCALL(numvp)
 493:	b8 1a 00 00 00       	mov    $0x1a,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret    

0000049b <numpp>:
SYSCALL(numpp)
 49b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 4a0:	cd 40                	int    $0x40
 4a2:	c3                   	ret    

000004a3 <mmap>:
 4a3:	b8 1c 00 00 00       	mov    $0x1c,%eax
 4a8:	cd 40                	int    $0x40
 4aa:	c3                   	ret    
 4ab:	66 90                	xchg   %ax,%ax
 4ad:	66 90                	xchg   %ax,%ax
 4af:	90                   	nop

000004b0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	57                   	push   %edi
 4b4:	56                   	push   %esi
 4b5:	53                   	push   %ebx
 4b6:	83 ec 3c             	sub    $0x3c,%esp
 4b9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 4bc:	89 d1                	mov    %edx,%ecx
{
 4be:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 4c1:	85 d2                	test   %edx,%edx
 4c3:	0f 89 7f 00 00 00    	jns    548 <printint+0x98>
 4c9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 4cd:	74 79                	je     548 <printint+0x98>
    neg = 1;
 4cf:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 4d6:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 4d8:	31 db                	xor    %ebx,%ebx
 4da:	8d 75 d7             	lea    -0x29(%ebp),%esi
 4dd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 4e0:	89 c8                	mov    %ecx,%eax
 4e2:	31 d2                	xor    %edx,%edx
 4e4:	89 cf                	mov    %ecx,%edi
 4e6:	f7 75 c4             	divl   -0x3c(%ebp)
 4e9:	0f b6 92 ac 0a 00 00 	movzbl 0xaac(%edx),%edx
 4f0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 4f3:	89 d8                	mov    %ebx,%eax
 4f5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 4f8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 4fb:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 4fe:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 501:	76 dd                	jbe    4e0 <printint+0x30>
  if(neg)
 503:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 506:	85 c9                	test   %ecx,%ecx
 508:	74 0c                	je     516 <printint+0x66>
    buf[i++] = '-';
 50a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 50f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 511:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 516:	8b 7d b8             	mov    -0x48(%ebp),%edi
 519:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 51d:	eb 07                	jmp    526 <printint+0x76>
 51f:	90                   	nop
 520:	0f b6 13             	movzbl (%ebx),%edx
 523:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 526:	83 ec 04             	sub    $0x4,%esp
 529:	88 55 d7             	mov    %dl,-0x29(%ebp)
 52c:	6a 01                	push   $0x1
 52e:	56                   	push   %esi
 52f:	57                   	push   %edi
 530:	e8 be fe ff ff       	call   3f3 <write>
  while(--i >= 0)
 535:	83 c4 10             	add    $0x10,%esp
 538:	39 de                	cmp    %ebx,%esi
 53a:	75 e4                	jne    520 <printint+0x70>
    putc(fd, buf[i]);
}
 53c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 53f:	5b                   	pop    %ebx
 540:	5e                   	pop    %esi
 541:	5f                   	pop    %edi
 542:	5d                   	pop    %ebp
 543:	c3                   	ret    
 544:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 548:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 54f:	eb 87                	jmp    4d8 <printint+0x28>
 551:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 558:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 55f:	90                   	nop

00000560 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 560:	f3 0f 1e fb          	endbr32 
 564:	55                   	push   %ebp
 565:	89 e5                	mov    %esp,%ebp
 567:	57                   	push   %edi
 568:	56                   	push   %esi
 569:	53                   	push   %ebx
 56a:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 56d:	8b 75 0c             	mov    0xc(%ebp),%esi
 570:	0f b6 1e             	movzbl (%esi),%ebx
 573:	84 db                	test   %bl,%bl
 575:	0f 84 b4 00 00 00    	je     62f <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
 57b:	8d 45 10             	lea    0x10(%ebp),%eax
 57e:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 581:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 584:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 586:	89 45 d0             	mov    %eax,-0x30(%ebp)
 589:	eb 33                	jmp    5be <printf+0x5e>
 58b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 58f:	90                   	nop
 590:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 593:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 598:	83 f8 25             	cmp    $0x25,%eax
 59b:	74 17                	je     5b4 <printf+0x54>
  write(fd, &c, 1);
 59d:	83 ec 04             	sub    $0x4,%esp
 5a0:	88 5d e7             	mov    %bl,-0x19(%ebp)
 5a3:	6a 01                	push   $0x1
 5a5:	57                   	push   %edi
 5a6:	ff 75 08             	pushl  0x8(%ebp)
 5a9:	e8 45 fe ff ff       	call   3f3 <write>
 5ae:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 5b1:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 5b4:	0f b6 1e             	movzbl (%esi),%ebx
 5b7:	83 c6 01             	add    $0x1,%esi
 5ba:	84 db                	test   %bl,%bl
 5bc:	74 71                	je     62f <printf+0xcf>
    c = fmt[i] & 0xff;
 5be:	0f be cb             	movsbl %bl,%ecx
 5c1:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 5c4:	85 d2                	test   %edx,%edx
 5c6:	74 c8                	je     590 <printf+0x30>
      }
    } else if(state == '%'){
 5c8:	83 fa 25             	cmp    $0x25,%edx
 5cb:	75 e7                	jne    5b4 <printf+0x54>
      if(c == 'd'){
 5cd:	83 f8 64             	cmp    $0x64,%eax
 5d0:	0f 84 9a 00 00 00    	je     670 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 5d6:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 5dc:	83 f9 70             	cmp    $0x70,%ecx
 5df:	74 5f                	je     640 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 5e1:	83 f8 73             	cmp    $0x73,%eax
 5e4:	0f 84 d6 00 00 00    	je     6c0 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5ea:	83 f8 63             	cmp    $0x63,%eax
 5ed:	0f 84 8d 00 00 00    	je     680 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5f3:	83 f8 25             	cmp    $0x25,%eax
 5f6:	0f 84 b4 00 00 00    	je     6b0 <printf+0x150>
  write(fd, &c, 1);
 5fc:	83 ec 04             	sub    $0x4,%esp
 5ff:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 603:	6a 01                	push   $0x1
 605:	57                   	push   %edi
 606:	ff 75 08             	pushl  0x8(%ebp)
 609:	e8 e5 fd ff ff       	call   3f3 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 60e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 611:	83 c4 0c             	add    $0xc,%esp
 614:	6a 01                	push   $0x1
 616:	83 c6 01             	add    $0x1,%esi
 619:	57                   	push   %edi
 61a:	ff 75 08             	pushl  0x8(%ebp)
 61d:	e8 d1 fd ff ff       	call   3f3 <write>
  for(i = 0; fmt[i]; i++){
 622:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 626:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 629:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 62b:	84 db                	test   %bl,%bl
 62d:	75 8f                	jne    5be <printf+0x5e>
    }
  }
}
 62f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 632:	5b                   	pop    %ebx
 633:	5e                   	pop    %esi
 634:	5f                   	pop    %edi
 635:	5d                   	pop    %ebp
 636:	c3                   	ret    
 637:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 63e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 640:	83 ec 0c             	sub    $0xc,%esp
 643:	b9 10 00 00 00       	mov    $0x10,%ecx
 648:	6a 00                	push   $0x0
 64a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 64d:	8b 45 08             	mov    0x8(%ebp),%eax
 650:	8b 13                	mov    (%ebx),%edx
 652:	e8 59 fe ff ff       	call   4b0 <printint>
        ap++;
 657:	89 d8                	mov    %ebx,%eax
 659:	83 c4 10             	add    $0x10,%esp
      state = 0;
 65c:	31 d2                	xor    %edx,%edx
        ap++;
 65e:	83 c0 04             	add    $0x4,%eax
 661:	89 45 d0             	mov    %eax,-0x30(%ebp)
 664:	e9 4b ff ff ff       	jmp    5b4 <printf+0x54>
 669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 670:	83 ec 0c             	sub    $0xc,%esp
 673:	b9 0a 00 00 00       	mov    $0xa,%ecx
 678:	6a 01                	push   $0x1
 67a:	eb ce                	jmp    64a <printf+0xea>
 67c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 680:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 683:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 686:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 688:	6a 01                	push   $0x1
        ap++;
 68a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 68d:	57                   	push   %edi
 68e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 691:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 694:	e8 5a fd ff ff       	call   3f3 <write>
        ap++;
 699:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 69c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 69f:	31 d2                	xor    %edx,%edx
 6a1:	e9 0e ff ff ff       	jmp    5b4 <printf+0x54>
 6a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6ad:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 6b0:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 6b3:	83 ec 04             	sub    $0x4,%esp
 6b6:	e9 59 ff ff ff       	jmp    614 <printf+0xb4>
 6bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6bf:	90                   	nop
        s = (char*)*ap;
 6c0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 6c3:	8b 18                	mov    (%eax),%ebx
        ap++;
 6c5:	83 c0 04             	add    $0x4,%eax
 6c8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 6cb:	85 db                	test   %ebx,%ebx
 6cd:	74 17                	je     6e6 <printf+0x186>
        while(*s != 0){
 6cf:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 6d2:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 6d4:	84 c0                	test   %al,%al
 6d6:	0f 84 d8 fe ff ff    	je     5b4 <printf+0x54>
 6dc:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 6df:	89 de                	mov    %ebx,%esi
 6e1:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6e4:	eb 1a                	jmp    700 <printf+0x1a0>
          s = "(null)";
 6e6:	bb a5 0a 00 00       	mov    $0xaa5,%ebx
        while(*s != 0){
 6eb:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 6ee:	b8 28 00 00 00       	mov    $0x28,%eax
 6f3:	89 de                	mov    %ebx,%esi
 6f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6ff:	90                   	nop
  write(fd, &c, 1);
 700:	83 ec 04             	sub    $0x4,%esp
          s++;
 703:	83 c6 01             	add    $0x1,%esi
 706:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 709:	6a 01                	push   $0x1
 70b:	57                   	push   %edi
 70c:	53                   	push   %ebx
 70d:	e8 e1 fc ff ff       	call   3f3 <write>
        while(*s != 0){
 712:	0f b6 06             	movzbl (%esi),%eax
 715:	83 c4 10             	add    $0x10,%esp
 718:	84 c0                	test   %al,%al
 71a:	75 e4                	jne    700 <printf+0x1a0>
 71c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 71f:	31 d2                	xor    %edx,%edx
 721:	e9 8e fe ff ff       	jmp    5b4 <printf+0x54>
 726:	66 90                	xchg   %ax,%ax
 728:	66 90                	xchg   %ax,%ax
 72a:	66 90                	xchg   %ax,%ax
 72c:	66 90                	xchg   %ax,%ax
 72e:	66 90                	xchg   %ax,%ax

00000730 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 730:	f3 0f 1e fb          	endbr32 
 734:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 735:	a1 5c 0d 00 00       	mov    0xd5c,%eax
{
 73a:	89 e5                	mov    %esp,%ebp
 73c:	57                   	push   %edi
 73d:	56                   	push   %esi
 73e:	53                   	push   %ebx
 73f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 742:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 744:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 747:	39 c8                	cmp    %ecx,%eax
 749:	73 15                	jae    760 <free+0x30>
 74b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 74f:	90                   	nop
 750:	39 d1                	cmp    %edx,%ecx
 752:	72 14                	jb     768 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 754:	39 d0                	cmp    %edx,%eax
 756:	73 10                	jae    768 <free+0x38>
{
 758:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 75a:	8b 10                	mov    (%eax),%edx
 75c:	39 c8                	cmp    %ecx,%eax
 75e:	72 f0                	jb     750 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 760:	39 d0                	cmp    %edx,%eax
 762:	72 f4                	jb     758 <free+0x28>
 764:	39 d1                	cmp    %edx,%ecx
 766:	73 f0                	jae    758 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 768:	8b 73 fc             	mov    -0x4(%ebx),%esi
 76b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 76e:	39 fa                	cmp    %edi,%edx
 770:	74 1e                	je     790 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 772:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 775:	8b 50 04             	mov    0x4(%eax),%edx
 778:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 77b:	39 f1                	cmp    %esi,%ecx
 77d:	74 28                	je     7a7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 77f:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 781:	5b                   	pop    %ebx
  freep = p;
 782:	a3 5c 0d 00 00       	mov    %eax,0xd5c
}
 787:	5e                   	pop    %esi
 788:	5f                   	pop    %edi
 789:	5d                   	pop    %ebp
 78a:	c3                   	ret    
 78b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 78f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 790:	03 72 04             	add    0x4(%edx),%esi
 793:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 796:	8b 10                	mov    (%eax),%edx
 798:	8b 12                	mov    (%edx),%edx
 79a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 79d:	8b 50 04             	mov    0x4(%eax),%edx
 7a0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7a3:	39 f1                	cmp    %esi,%ecx
 7a5:	75 d8                	jne    77f <free+0x4f>
    p->s.size += bp->s.size;
 7a7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 7aa:	a3 5c 0d 00 00       	mov    %eax,0xd5c
    p->s.size += bp->s.size;
 7af:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7b2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 7b5:	89 10                	mov    %edx,(%eax)
}
 7b7:	5b                   	pop    %ebx
 7b8:	5e                   	pop    %esi
 7b9:	5f                   	pop    %edi
 7ba:	5d                   	pop    %ebp
 7bb:	c3                   	ret    
 7bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000007c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7c0:	f3 0f 1e fb          	endbr32 
 7c4:	55                   	push   %ebp
 7c5:	89 e5                	mov    %esp,%ebp
 7c7:	57                   	push   %edi
 7c8:	56                   	push   %esi
 7c9:	53                   	push   %ebx
 7ca:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7cd:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7d0:	8b 3d 5c 0d 00 00    	mov    0xd5c,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7d6:	8d 70 07             	lea    0x7(%eax),%esi
 7d9:	c1 ee 03             	shr    $0x3,%esi
 7dc:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 7df:	85 ff                	test   %edi,%edi
 7e1:	0f 84 a9 00 00 00    	je     890 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7e7:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 7e9:	8b 48 04             	mov    0x4(%eax),%ecx
 7ec:	39 f1                	cmp    %esi,%ecx
 7ee:	73 6d                	jae    85d <malloc+0x9d>
 7f0:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 7f6:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7fb:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 7fe:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 805:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 808:	eb 17                	jmp    821 <malloc+0x61>
 80a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 810:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 812:	8b 4a 04             	mov    0x4(%edx),%ecx
 815:	39 f1                	cmp    %esi,%ecx
 817:	73 4f                	jae    868 <malloc+0xa8>
 819:	8b 3d 5c 0d 00 00    	mov    0xd5c,%edi
 81f:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 821:	39 c7                	cmp    %eax,%edi
 823:	75 eb                	jne    810 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 825:	83 ec 0c             	sub    $0xc,%esp
 828:	ff 75 e4             	pushl  -0x1c(%ebp)
 82b:	e8 2b fc ff ff       	call   45b <sbrk>
  if(p == (char*)-1)
 830:	83 c4 10             	add    $0x10,%esp
 833:	83 f8 ff             	cmp    $0xffffffff,%eax
 836:	74 1b                	je     853 <malloc+0x93>
  hp->s.size = nu;
 838:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 83b:	83 ec 0c             	sub    $0xc,%esp
 83e:	83 c0 08             	add    $0x8,%eax
 841:	50                   	push   %eax
 842:	e8 e9 fe ff ff       	call   730 <free>
  return freep;
 847:	a1 5c 0d 00 00       	mov    0xd5c,%eax
      if((p = morecore(nunits)) == 0)
 84c:	83 c4 10             	add    $0x10,%esp
 84f:	85 c0                	test   %eax,%eax
 851:	75 bd                	jne    810 <malloc+0x50>
        return 0;
  }
}
 853:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 856:	31 c0                	xor    %eax,%eax
}
 858:	5b                   	pop    %ebx
 859:	5e                   	pop    %esi
 85a:	5f                   	pop    %edi
 85b:	5d                   	pop    %ebp
 85c:	c3                   	ret    
    if(p->s.size >= nunits){
 85d:	89 c2                	mov    %eax,%edx
 85f:	89 f8                	mov    %edi,%eax
 861:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 868:	39 ce                	cmp    %ecx,%esi
 86a:	74 54                	je     8c0 <malloc+0x100>
        p->s.size -= nunits;
 86c:	29 f1                	sub    %esi,%ecx
 86e:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 871:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 874:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 877:	a3 5c 0d 00 00       	mov    %eax,0xd5c
}
 87c:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 87f:	8d 42 08             	lea    0x8(%edx),%eax
}
 882:	5b                   	pop    %ebx
 883:	5e                   	pop    %esi
 884:	5f                   	pop    %edi
 885:	5d                   	pop    %ebp
 886:	c3                   	ret    
 887:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 88e:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 890:	c7 05 5c 0d 00 00 60 	movl   $0xd60,0xd5c
 897:	0d 00 00 
    base.s.size = 0;
 89a:	bf 60 0d 00 00       	mov    $0xd60,%edi
    base.s.ptr = freep = prevp = &base;
 89f:	c7 05 60 0d 00 00 60 	movl   $0xd60,0xd60
 8a6:	0d 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8a9:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 8ab:	c7 05 64 0d 00 00 00 	movl   $0x0,0xd64
 8b2:	00 00 00 
    if(p->s.size >= nunits){
 8b5:	e9 36 ff ff ff       	jmp    7f0 <malloc+0x30>
 8ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 8c0:	8b 0a                	mov    (%edx),%ecx
 8c2:	89 08                	mov    %ecx,(%eax)
 8c4:	eb b1                	jmp    877 <malloc+0xb7>
