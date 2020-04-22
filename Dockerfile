FROM node:alpine
WORKDIR '/app'
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx
# Elastic Beanstalk will use Dockerfile (not the dev one) to deploy the app so need to expose port here for web based requests
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html