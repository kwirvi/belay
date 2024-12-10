
function showSection(sectionClass) {
    // Hide all sections
    document.querySelectorAll('.layout > *').forEach((section) => {
      section.classList.remove('active');
    });
  
    // Show the selected section
    document.querySelector(`.${sectionClass}`).classList.add('active');
  }


