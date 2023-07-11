# Use a lightweight web server as the base image
FROM nginx:latest

# Copy the website files to the default web server directory
COPY . /usr/share/nginx/html

# Expose the port that the website will be running on
EXPOSE 80

# Set the command to start the web server
CMD ["nginx", "-g", "daemon off;"]
