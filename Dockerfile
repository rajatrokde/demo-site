# Use an official Python runtime as the base image
FROM python:3.9

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file to the container
COPY requirements.txt .

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the website files to the container
COPY . .

# Expose the port that the website will be running on
EXPOSE 80

# Set the command to run the website
CMD ["python", "app.py"]
