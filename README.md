# My Portfolio Project 😎🚀

This project started as a fun way to build a sleek portfolio website for me that highlights my projects and skills. I developed the front-end using HTML, CSS, and JavaScript, customizing a template to fit my style perfectly.

Then, I took it further by containerizing the site with Docker, pushing the image to AWS ECR, and deploying it on AWS ECS. All the infrastructure is managed with Terraform, automated seamlessly through a Spacelift CI/CD pipeline.

Here is the tree structure of this repo mapped out by me for you, because I am kind 😁😁😁.

👇👇👇

```
📂 my_portfolio_project 😎🚀
├── 📁 assets 🎨
│   ├── 📁 css 💅
│   ├── 📁 images 🖼️
│   └── 📁 js 💻
├── 📁 terraform 🌍
│   ├── 🗂️ ecr.tf 📦
│   ├── 🗂️ ecs.tf 🚢
│   ├── 🗂️ iam.tf 🔐
│   ├── 🗂️ main.tf 🏗️
│   ├── 🗂️ provider.tf 🔧
│   ├── 🗂️ security.tf 🛡️
│   ├── 🗂️ vpc.tf 🌐
│   ├── 📁 .github 🤖
│   ├── 🔒 .terraform.lock.hcl
│   └── 🗃️ .terraform/
├── 🐳 Dockerfile 🐋
├── 📄 .dockerignore 🚫🐳
├── 📄 index.html 🌟
├── 📄 README.md 📚
└── 🛠️ workflows/ 🔄
```

Keep it neat, keep it tight! 💪😄


---

## What’s Inside?

- Fully customized front-end crafted with HTML, CSS, and JavaScript  
- Dockerized container running on Nginx  
- Infrastructure as Code using Terraform to provision AWS VPC, SECURITY, IAM, ECR, ECS
- Automated deployment via Spacelift pipeline  

---

## Getting Started

I didn’t want to waste time trying to design the best looking version from scratch, so with my eagle eyes I started with a base template, then applied my front-end web dev skills to make it uniquely mine — focusing on clean, responsive design and smooth user experience. I even took a portrait photoshoot by myself and added it just for fun! 🎉  

Then, I showcased my Cloud DevOps skills through Infrastructure, Containerization, and CI/CD automation — bringing the project full circle.  

---

## Tools & Technologies

HTML | CSS | JavaScript | Docker | Nginx | AWS ECR | AWS ECS | Terraform | Spacelift  

---

In the near future, expect more fun features and styles coming to this app... Stay tuned! 😄✨


## Architectural diagram
![Architect](https://raw.githubusercontent.com/AkingbadeOmosebi/My_Porfolio/main/assets/screenshots/Architectural_Diagram.png)

Here are some preview.

## App Preview

Here are some screenshots of the app running:

### Outputs
![outputs1](https://raw.githubusercontent.com/AkingbadeOmosebi/My_Porfolio/main/assets/screenshots/Output1.png)
![outputs2](https://raw.githubusercontent.com/AkingbadeOmosebi/My_Porfolio/main/assets/screenshots/Output2.png)
![output3](https://raw.githubusercontent.com/AkingbadeOmosebi/My_Porfolio/main/assets/screenshots/Output3.png)

### AWS-ECS-Clusters
![ECS](https://raw.githubusercontent.com/AkingbadeOmosebi/My_Porfolio/main/assets/screenshots/Cluster1.png)
![ECS2](https://raw.githubusercontent.com/AkingbadeOmosebi/My_Porfolio/main/assets/screenshots/Service_Task.png)
![ECS3](https://raw.githubusercontent.com/AkingbadeOmosebi/My_Porfolio/main/assets/screenshots/Cluster2.png)

### AWS-ECS-Task Definitions
![ECS](https://raw.githubusercontent.com/AkingbadeOmosebi/My_Porfolio/main/assets/screenshots/TD1.png)
![ECS2](https://raw.githubusercontent.com/AkingbadeOmosebi/My_Porfolio/main/assets/screenshots/TD2.png)
![ECS3](https://raw.githubusercontent.com/AkingbadeOmosebi/My_Porfolio/main/assets/screenshots/td3.png)

### AWS-ECR
![ECR](https://raw.githubusercontent.com/AkingbadeOmosebi/My_Porfolio/main/assets/screenshots/Docker_ECR.png)
![ECR](https://raw.githubusercontent.com/AkingbadeOmosebi/My_Porfolio/main/assets/screenshots/ECR_IMG.png)

### Spacelift Terraform IaC CI-CD
![spacelift1](https://raw.githubusercontent.com/AkingbadeOmosebi/My_Porfolio/main/assets/screenshots/Spacelift.png)
![spacelift2](https://raw.githubusercontent.com/AkingbadeOmosebi/My_Porfolio/main/assets/screenshots/Spacelift_final.png)
![spacelift3](https://raw.githubusercontent.com/AkingbadeOmosebi/My_Porfolio/main/assets/screenshots/spacelift_3.png)




Hope you enjoyed. 😎