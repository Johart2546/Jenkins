FROM jenkins/jenkins:lts
USER root

# ติดตั้ง Docker CLI ใน Jenkins container
RUN apt-get update && apt-get install -y docker.io

# เพิ่ม user jenkins เข้าไปในกลุ่ม docker
RUN usermod -aG docker jenkins

USER jenkins