# I will be using the Nginx alpine image as the base image
FROM nginx:alpine

# to copy the contents of the current directory to the /usr/share/nginx/html directory in the container.
COPY . /usr/share/nginx/html

# i will expose port 80 from Nginx. This is the port that Nginx will listen on inside the container.
EXPOSE 80
