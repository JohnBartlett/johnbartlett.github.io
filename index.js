// This is an additional security layer for GitHub Pages where .htaccess may not work
// This script will redirect users to password.html if accessed directly
(function() {
  // Only run this on the main page, not on the password page
  if (window.location.pathname.endsWith('/index.html') || 
      window.location.pathname === '/' || 
      window.location.pathname.endsWith('/')) {
      
    // Check if user has authenticated in this session
    const isAuthenticated = sessionStorage.getItem('authenticated') === 'true';
    
    // If not authenticated, redirect to password page
    if (!isAuthenticated) {
      window.location.href = 'password.html';
    }
  }
})();