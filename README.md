# My Portfolio Project 😎🚀

This project started as a fun way to build a sleek portfolio website for me that highlights my projects and skills. I developed the front-end using HTML, CSS, and JavaScript, customizing a template to fit my style perfectly.

Then, I took it further by containerizing the site with Docker, pushing the image to AWS ECR, and deploying it on AWS ECS. All the infrastructure is managed with Terraform, automated seamlessly through a Spacelift CI/CD pipeline.

Here is the tree structure of this repo mapped out by me for you, because I am kind 😁😁😁.

👇👇👇

My_Porfolio/
│
├── 🐳 Dockerfile # Docker configuration for containerizing the app
├── 🚫 .dockerignore # Files/folders to exclude from Docker build context
├── 📚 README.md # Project overview and instructions
│
├── 🌍 terraform/ # All Infrastructure as Code (IaC) files
│ ├── 🏗️ main.tf # Main Terraform config (or split into modules)
│ ├── 🔧 provider.tf # Terraform provider settings
│ ├── 🌐 vpc.tf # VPC and networking resources
│ ├── 🛡️ security.tf # Security groups and IAM roles
│ ├── 🚢 ecs.tf # ECS cluster, services, task definitions
│ ├── 📦 ecr.tf # ECR repository and lifecycle policies
│ ├── 🔐 iam.tf # IAM roles and policies
│ ├── 🔄 workflows/ # GitHub Actions workflow files for CI/CD
│ └── 📁 assets/ # Terraform related static files or templates (if any)
│
├── 🌟 index.html # Your portfolio website HTML entry point
├── 🎨 assets/ # Frontend assets: css, js, images, etc.
│ ├── 💅 css/
│ ├── 💻 js/
│ └── 🖼️ images/
└── 🚫 .gitignore # Git ignore rules


---

## What’s Inside?

- Fully customized front-end crafted with HTML, CSS, and JavaScript  
- Dockerized container running on Nginx  
- Infrastructure as Code using Terraform  
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

