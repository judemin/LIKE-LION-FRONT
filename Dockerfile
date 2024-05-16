# 베이스 이미지로 Node.js를 사용합니다.
FROM node:14

# 작업 디렉토리를 설정합니다.
WORKDIR /app

# package.json과 package-lock.json을 복사합니다.
COPY package*.json ./

# 의존성 패키지를 설치합니다.
RUN npm ci

# 소스 코드를 복사합니다.
COPY . .

# React 애플리케이션을 빌드합니다.
RUN npm run build

# Nginx를 설치합니다.
RUN apt-get update && apt-get install -y nginx

# Nginx 기본 설정 파일을 삭제합니다.
RUN rm /etc/nginx/sites-enabled/default

# Nginx 설정 파일을 복사합니다.
COPY nginx.conf /etc/nginx/conf.d

# 빌드된 React 파일을 Nginx 디렉토리로 복사합니다.
RUN cp -r build/* /usr/share/nginx/html

# 포트 80을 노출합니다.
EXPOSE 80

# Nginx를 실행합니다.
CMD ["nginx", "-g", "daemon off;"]

