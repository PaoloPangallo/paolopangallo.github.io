const menuToggle = document.querySelector('#menu-toggle');
const navigation = document.querySelector('#site-navigation');
if (menuToggle && navigation) {
  const closeMenu = () => {
    navigation.classList.remove('nav-open');
    menuToggle.setAttribute('aria-expanded', 'false');
    menuToggle.setAttribute('aria-label', 'Open navigation menu');
  };
  menuToggle.addEventListener('click', () => {
    const open = !navigation.classList.contains('nav-open');
    navigation.classList.toggle('nav-open', open);
    menuToggle.setAttribute('aria-expanded', String(open));
    menuToggle.setAttribute('aria-label', open ? 'Close navigation menu' : 'Open navigation menu');
  });
  navigation.querySelectorAll('a').forEach(link => link.addEventListener('click', closeMenu));
  document.addEventListener('keydown', e => { if (e.key === 'Escape') closeMenu(); });
  document.addEventListener('click', e => { if (!navigation.contains(e.target) && !menuToggle.contains(e.target)) closeMenu(); });
}

const filters = [...document.querySelectorAll('.filter')];
const cards = [...document.querySelectorAll('.project-card')];
filters.forEach(button => button.addEventListener('click', () => {
  const filter = button.dataset.filter;
  filters.forEach(f => {
    const isActive = f === button;
    f.classList.toggle('is-active', isActive);
    f.setAttribute('aria-pressed', String(isActive));
  });
  cards.forEach(card => {
    const cats = (card.dataset.category || '').split(/\s+/);
    card.hidden = filter !== 'all' && !cats.includes(filter);
  });
}));

const revealEls = document.querySelectorAll('[data-reveal]');
if ('IntersectionObserver' in window && !window.matchMedia('(prefers-reduced-motion: reduce)').matches) {
  const observer = new IntersectionObserver(entries => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('revealed');
        observer.unobserve(entry.target);
      }
    });
  }, { threshold: 0.08, rootMargin: '0px 0px 40px 0px' });
  revealEls.forEach(el => observer.observe(el));
} else {
  revealEls.forEach(el => el.classList.add('revealed'));
}

const year = document.querySelector('#year');
if (year) year.textContent = String(new Date().getFullYear());
