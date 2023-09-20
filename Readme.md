2023.09.06 현재 작업해야할 것들 
-기본적인 ec2, vpc 인프라 usrdata까지 구축 
-작업중이 내용 git upload

2023.09.07 
-today's to do 
-s3 , alb , rds 연동
-지금 작업중인 프로젝트 와 합치기 (오전중)
- s3로 원격 상태관리
- 도커 앱에서 빌드해서 실제로 작동하는지 확인(오후 도커파일 만들기) 및 관련 세팅만들기 
- DB S3 연동해보기 
- secureshell 포트 22번 연결해서 접속해보기 
시간남으면 acm + loadbalancer 연동

2023.09.08
- 나중에 리눅스 서버에서 작업하도록 기본적인 도커파일 및       도커컴포즈파일을 로걸에서 구성 (nginx, frontend)
-2023.09.12
- ec2, alb, rds, s3, vpc 인프라 구성
- 향후 업데이트할 ecs 인프라 아키텍쳐 설계
- s3 버킷정책 cors 및 권한 부여
- s3 원격state 버전관리
- Route53 생성 및 ACM 생성(Cname 설정)

2023.09.13
- terraform route53구축 
- 전반적인 인프라를 구축했음에도 불구하고 502서버 오류 발생
- git에서 dev와 main 브랜치 나눠서 관리 

2023.09.14
- 기존 아키텍쳐 ec2-bastion를 public에 추가한 아키텍쳐 변경
- ec2 부트스트래핑시 도커 미설치로 인한 userdata.sh 파일 수정
- mobaxterm을 사용한 ssh 통신 까지 진행 
- AWS 비용확인 s3 bucket으로 관리 및 billing으로 예산 확인 및 알림 설정

2023.09.15
- terraform AutoScaling 코드 추가예정
- 도커까지 설치를 하고 기본적인 프론트와 nginx가 구축된 ami 생성 예쩡
- 테라폼 코드와 프론트 코드 merger 예정 
- gitignore을 이용해서 main에 시크릿코드를 관리했는데 env설정으로 변경

2023.09.18
도커 컨테이너에서 빌드중 컨테이너에서 실행중인 앱이 자동종료되는 오류 파악 및 해결

2023.09.19
-autoscaling코드 절반정도 구현
-acm 인증 및 www.philoberry.com 온라인에 게시 성공
- 컨테이너 이미지 도커hub에 업로드 


2023.09.20
-ami 생성 및 launch_template 코드로 구현
- autoscaling까지 기본 아키텍쳐 구현 완료
-ECS로 아키텍쳐 전환준비
