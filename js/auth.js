// Authentication check for password protection
(function() {
    // Check if user has already authenticated in this session
    const isAuthenticated = sessionStorage.getItem('authenticated') === 'true';
    
    // If not authenticated, redirect to password page
    if (!isAuthenticated) {
        // Get the current page path
        const currentPath = window.location.pathname;
        const currentFile = currentPath.split('/').pop();
        
        // Only redirect if not already on the password page
        if (currentFile !== 'password.html') {
            window.location.href = 'password.html';
        }
    }
})();