# John F. Bartlett - AI Strategy & Implementation Consultant

Professional website for AI consulting services, built with Jekyll and deployed on GitHub Pages.

## Site Structure

- **Framework**: Jekyll (GitHub Pages compatible)
- **Layout**: Custom responsive design
- **Navigation**: Fixed header with smooth scrolling
- **Sections**: Hero, Services, Results, Free Services, About, Contact, Portfolio Analysis

## Recent Changes & Version History

### Version 3.2.19 (Current)
- **Added**: Free Services section with three high-value offerings
  - AI Readiness Assessment (30-minute evaluation)
  - Process Automation Audit (identify automation opportunities)
  - AI Strategy Session (90-day roadmap)
- **Features**: Professional card layout, hover effects, clear CTAs
- **Messaging**: "No strings attached" to build trust

### Version 3.2.18
- **Added**: Site-wide version tracking system
- **Feature**: Version display in footer (v3.2.18)
- **Config**: Added version field to _config.yml

### Version 3.2.17
- **Changed**: Service pricing from specific amounts to "Contact for Quote"
- **Reasoning**: More flexible pricing approach, removes sticker shock
- **Impact**: Encourages direct contact for customized quotes

### Version 3.2.16
- **Added**: Font Awesome icons to credentials section
- **Icons**: AWS, Google, Shield, Users, Globe
- **Styling**: Professional icon alignment with brand colors
- **CDN**: Font Awesome 6.4.0 for reliable icon delivery

### Version 3.2.15
- **Removed**: Emojis from credentials section
- **Reasoning**: More professional appearance for business consulting
- **Result**: Clean, text-only credential display

### Version 3.2.14
- **Added**: Google Cloud Digital Leader certification
- **Placement**: Between Google CyberSecurity Analyst and professional memberships
- **Format**: Consistent with existing credential styling

### Version 3.2.13
- **Major**: Converted from static HTML to Jekyll structure
- **Added**: _config.yml, _layouts/, _pages/ directories
- **Created**: Portfolio Analysis page with comprehensive content
- **Navigation**: Added Portfolio Analysis link to site navigation
- **Dependencies**: Added Gemfile for Jekyll dependencies

## Technical Details

### Jekyll Configuration
- **Theme**: Custom (no external theme)
- **Markdown**: Kramdown
- **Highlighter**: Rouge
- **Collections**: Pages with custom permalinks

### Layouts
- **default.html**: Main layout with navigation and footer
- **home.html**: Homepage with all sections
- **page.html**: Standard page layout for content pages

### Key Features
- **Responsive Design**: Mobile-first approach
- **Smooth Scrolling**: Navigation with offset for fixed header
- **Form Integration**: Formspree for contact form handling
- **Icon Integration**: Font Awesome for professional icons
- **Version Tracking**: Site-wide version display

### Content Sections
1. **Hero**: Value proposition with key statistics
2. **Services**: Four main service offerings with features
3. **Results**: Proven outcomes with metrics
4. **Free Services**: Three complimentary offerings for lead generation
5. **About**: Professional background and credentials
6. **Contact**: Contact information and consultation form
7. **Portfolio Analysis**: Comprehensive GitHub project analysis

## Development Workflow

### Version Management
- **Format**: 3.2.X (Major.Minor.Patch)
- **Auto-increment**: Version updated with each change
- **Display**: Version shown in footer as "v3.2.19"
- **Commit**: Version included in commit messages

### Deployment
- **Platform**: GitHub Pages
- **Build**: Automatic Jekyll build on push to main
- **URL**: https://johnbartlett.github.io/
- **Custom Domain**: Not configured

## File Structure
```
johnbartlett.github.io/
├── _config.yml          # Jekyll configuration
├── _layouts/            # Jekyll layouts
│   ├── default.html     # Main layout
│   ├── home.html        # Homepage layout
│   └── page.html        # Page layout
├── _pages/              # Content pages
│   └── portfolio-analysis.md
├── assets/              # Static assets
├── index.html           # Homepage
├── Gemfile              # Jekyll dependencies
└── README.md            # This file
```

## Contact Information
- **Email**: AIConsulting@chrnt.com
- **Location**: Saint Petersburg, Florida
- **LinkedIn**: linkedin.com/in/johnfbartlett
- **Services**: AI Strategy, Manufacturing AI, Infrastructure, Training

---
*Last updated: Version 3.2.19 - Free Services section added*
