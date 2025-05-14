document.addEventListener('DOMContentLoaded', function() {
  // Theme toggle functionality
  const themeToggle = document.getElementById('theme-toggle');
  const darkIcon = document.getElementById('dark-icon');
  const lightIcon = document.getElementById('light-icon');
  
  // Check for saved theme preference or use browser preference
  const savedTheme = localStorage.getItem('theme');
  const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
  
  // Set initial theme
  if (savedTheme === 'dark' || (!savedTheme && prefersDark)) {
    document.documentElement.setAttribute('data-theme', 'dark');
    darkIcon.style.display = 'none';
    lightIcon.style.display = 'block';
  }
  
  // Theme toggle click handler
  themeToggle.addEventListener('click', () => {
    const currentTheme = document.documentElement.getAttribute('data-theme');
    if (currentTheme === 'dark') {
      document.documentElement.removeAttribute('data-theme');
      localStorage.setItem('theme', 'light');
      darkIcon.style.display = 'block';
      lightIcon.style.display = 'none';
    } else {
      document.documentElement.setAttribute('data-theme', 'dark');
      localStorage.setItem('theme', 'dark');
      darkIcon.style.display = 'none';
      lightIcon.style.display = 'block';
    }
  });
  // Smooth scrolling for anchor links
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function(e) {
      e.preventDefault();
      const targetId = this.getAttribute('href').substring(1);
      const targetElement = document.getElementById(targetId);
      
      if (targetElement) {
        window.scrollTo({
          top: targetElement.offsetTop - 80, // Accounting for fixed header
          behavior: 'smooth'
        });
        
        // Update URL without scrolling
        history.pushState(null, null, `#${targetId}`);
      }
    });
  });
  
  // Header links active state based on scroll position
  const sections = document.querySelectorAll('section');
  const navLinks = document.querySelectorAll('.nav-link');
  
  function setActiveLink() {
    let current = '';
    
    sections.forEach(section => {
      const sectionTop = section.offsetTop - 90;
      const sectionHeight = section.offsetHeight;
      
      if (window.scrollY >= sectionTop && window.scrollY < sectionTop + sectionHeight) {
        current = section.getAttribute('id');
      }
    });
    
    navLinks.forEach(link => {
      link.classList.remove('active');
      if (link.getAttribute('href') === `#${current}`) {
        link.classList.add('active');
      }
    });
  }
  
  window.addEventListener('scroll', setActiveLink);
  
  // Project filtering
  const filterButtons = document.querySelectorAll('.filter-button');
  const projectCards = document.querySelectorAll('.project-card');
  
  filterButtons.forEach(button => {
    button.addEventListener('click', () => {
      // Update active button
      filterButtons.forEach(btn => btn.classList.remove('active'));
      button.classList.add('active');
      
      const filterValue = button.getAttribute('data-filter');
      
      // Show/hide projects based on filter
      projectCards.forEach(card => {
        if (filterValue === 'all' || card.getAttribute('data-category') === filterValue) {
          card.style.display = 'flex';
          setTimeout(() => {
            card.style.opacity = '1';
            card.style.transform = 'translateY(0)';
          }, 10);
        } else {
          card.style.opacity = '0';
          card.style.transform = 'translateY(20px)';
          setTimeout(() => {
            card.style.display = 'none';
          }, 300);
        }
      });
    });
  });
  
  // Replit app filtering
  const replitFilterButtons = document.querySelectorAll('.replit-filter-button');
  const replitCards = document.querySelectorAll('.replit-card');
  
  replitFilterButtons.forEach(button => {
    button.addEventListener('click', () => {
      // Update active button
      replitFilterButtons.forEach(btn => btn.classList.remove('active'));
      button.classList.add('active');
      
      const filterValue = button.getAttribute('data-filter');
      
      // Show/hide replit apps based on filter
      replitCards.forEach(card => {
        if (filterValue === 'all' || card.getAttribute('data-category') === filterValue) {
          card.style.display = 'block';
          setTimeout(() => {
            card.style.opacity = '1';
            card.style.transform = 'translateY(0)';
          }, 10);
        } else {
          card.style.opacity = '0';
          card.style.transform = 'translateY(20px)';
          setTimeout(() => {
            card.style.display = 'none';
          }, 300);
        }
      });
    });
  });
  
  // Contact form with FormSpree integration
  const contactForm = document.getElementById('contact-form');
  
  if (contactForm) {
    // Client-side validation and FormSpree submission
    contactForm.addEventListener('submit', function(e) {
      e.preventDefault();
      
      // Validation happens before FormSpree submission
      const name = document.getElementById('name').value;
      const company = document.getElementById('company').value;
      const email = document.getElementById('email').value;
      const industry = document.getElementById('industry').value;
      const subject = document.getElementById('subject').value;
      const message = document.getElementById('message').value;
      
      if (!name || !email || !subject || !message) {
        alert('Please fill in all required fields');
        return false;
      }
      
      // Add business context to the form data for better lead qualification
      if (company) {
        document.getElementById('subject').value = `${subject} - ${company}`;
      }
      
      // Add industry information to the message if provided
      if (industry) {
        const industryInfo = `\n\nIndustry: ${industry}`;
        document.getElementById('message').value = message + industryInfo;
      }
      
      if (!isValidEmail(email)) {
        alert('Please enter a valid email address');
        return false;
      }
      
      // If we've made it here, we'll submit to FormSpree via AJAX
      let form = e.target;
      let formData = new FormData(form);
      let xhr = new XMLHttpRequest();
      xhr.open(form.method, form.action);
      xhr.setRequestHeader("Accept", "application/json");
      xhr.onreadystatechange = function() {
        if (xhr.readyState !== XMLHttpRequest.DONE) return;
        if (xhr.status === 200) {
          form.style.display = 'none';
          const successMessage = document.getElementById('form-success');
          if (successMessage) {
            successMessage.style.display = 'flex';
          }
          form.reset();
        } else {
          alert("Oops! There was a problem sending your message. Please try again.");
        }
      };
      xhr.send(formData);
    });
  }
  
  function isValidEmail(email) {
    const re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(String(email).toLowerCase());
  }
  
  // Back to top button functionality
  const backToTopButton = document.querySelector('.back-to-top');
  
  if (backToTopButton) {
    backToTopButton.addEventListener('click', function(e) {
      e.preventDefault();
      window.scrollTo({
        top: 0,
        behavior: 'smooth'
      });
    });
  }
  
  // Animation on scroll
  const animatedElements = document.querySelectorAll('.animate-on-scroll');
  
  const animateOnScroll = function() {
    animatedElements.forEach(element => {
      const elementPosition = element.getBoundingClientRect();
      const windowHeight = window.innerHeight;
      
      if (elementPosition.top < windowHeight * 0.9) {
        const animationClass = element.getAttribute('data-animation') || 'fade-in';
        element.classList.add(animationClass);
        element.style.opacity = 1;
      }
    });
  };
  
  window.addEventListener('scroll', animateOnScroll);
  animateOnScroll(); // Run once on page load
});