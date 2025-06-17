"use strict";

const NN_CONFIG = {
  elements: {
    nav: "nav",
    footer: "#section-footer",
  },
  shakeDuration: 1000,
  moveDuration: 500,
  fadeDuration: 500,
  useRotation: true,
  __DEBUG: false,
};

const NN_styleElement = document.createElement("style");
NN_styleElement.innerHTML = `.NN_shake {
  animation: NN_shake 0.25s infinite;
}

@keyframes NN_shake {
  0% {
    transform: translateX(0);
  }
  25% {
    transform: translateX(5px);
  }
  50% {
    transform: translateX(-5px);
  }
  75% {
    transform: translateX(5px);
  }
  100% {
    transform: translateX(0);
  }
}`;
document.head.appendChild(NN_styleElement);

/**
 *
 * @param {string} msg
 * @param  {...any} args
 * @returns {void}
 */
const NN__DEBUG_LOG = (msg, ...args) => console.log(`[NN] ${msg}`, ...args);

const NN_nav = document.querySelector(NN_CONFIG.elements.nav);
const NN_footer = document.querySelector(NN_CONFIG.elements.footer);
const NN_screenCentre = { x: 0, y: 0 };

function NN_resize() {
  NN_screenCentre.x = window.innerWidth / 2;
  NN_screenCentre.y = window.innerHeight / 2;
}

window.addEventListener("resize", () => NN_resize());
NN_resize();

/**
 *
 * @param {HTMLElement} element
 * @param {string} name
 * @param {Array<keyof HTMLElementTagNameMap>} wrapperTags
 * @returns {HTMLElement} floatingWrapper
 */
function NN_floatElement(element, name, wrapperTags = []) {
  if (!element) {
    console.error("Element not found:", element);
    return;
  }

  // Get original dimensions and position
  const rect = element.getBoundingClientRect();
  const computedStyle = window.getComputedStyle(element);

  // Create a placeholder
  const placeholder = document.createElement("div");
  placeholder.style.width = `${rect.width}px`;
  placeholder.style.height = `${rect.height}px`;
  placeholder.style.display = computedStyle.display;
  placeholder.style.visibility = "hidden"; // Keeps layout but hides it visually

  // Insert placeholder and remove the original from the flow
  element.parentNode.insertBefore(placeholder, element);

  // Create a floating wrapper
  let floatingWrapper = document.createElement("div");
  floatingWrapper.style.position = "absolute";
  floatingWrapper.style.left = `${rect.left + window.scrollX}px`;
  floatingWrapper.style.top = `${rect.top + window.scrollY}px`;
  floatingWrapper.style.width = `${rect.width}px`;
  floatingWrapper.style.height = `${rect.height}px`;
  floatingWrapper.style.zIndex = "9999"; // Ensure it's above other content
  floatingWrapper.style.pointerEvents = "auto"; // Allow interaction

  // Wrap the floating element inside the provided tag structure
  let currentWrapper = floatingWrapper;
  wrapperTags.forEach((tag) => {
    const newWrapper = document.createElement(tag);

    // Apply a CSS reset to prevent inherited styles
    newWrapper.style.all = "unset"; // Removes inherited styles
    newWrapper.style.display = "contents"; // Makes wrapper tags non-intrusive

    currentWrapper.appendChild(newWrapper);
    currentWrapper = newWrapper;
  });

  // Move the original element inside the deepest wrapper
  element.style.margin = "0"; // Remove margins to prevent weird spacing issues
  currentWrapper.appendChild(element);

  // Add the floating wrapper to the body
  document.body.appendChild(floatingWrapper);

  // Allow manual repositioning using CSS
  // floatingWrapper.classList.add(`floating-element-${name}`); // Can be styled with CSS
  floatingWrapper.id = `floating-element-${name}`;

  return floatingWrapper;
}

/**
 *
 * @param {HTMLElement} element
 * @param {Number} targetX
 * @param {Number} targetY
 * @param {Number} duration
 */
function NN_moveElement(element, targetX, targetY, vanishOnComplete = false) {
  const startX = parseInt(element.style.left) || 0;
  const startY = parseInt(element.style.top) || 0;

  const startTime = performance.now();

  if (NN_CONFIG.__DEBUG) {
    NN__DEBUG_LOG(`Moving element ${element.id} to (${targetX}, ${targetY})`);
  }

  /**
   *
   * @param {DOMHighResTimeStamp} time
   */
  function animate(time) {
    const elapsed = time - startTime;
    const progress = Math.min(elapsed / NN_CONFIG.moveDuration, 1);

    element.style.left = `${startX + (targetX - startX) * progress}px`;
    element.style.top = `${startY + (targetY - startY) * progress}px`;

    if (NN_CONFIG.useRotation) {
      element.style.transform = `rotate(${progress * 90}deg)`;
    }

    if (progress < 1) {
      requestAnimationFrame(animate);
    } else if (progress >= 1 && vanishOnComplete) {
      element.style.transition = `opacity ${NN_CONFIG.fadeDuration}ms`;
      element.style.opacity = 0;

      setTimeout(() => {
        element.style.visibility = "hidden";
      }, NN_CONFIG.fadeDuration + 100);
    }
  }

  requestAnimationFrame(animate);
}

/**
 *
 * @param {Number} ms
 * @returns {Promise<void>}
 */
async function NN_wait(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

async function NN_activateNightNight() {
  window.scrollTo(0, 0);

  const floatingNav = NN_floatElement(NN_nav, "nav", ["header"]);

  if (NN_CONFIG.__DEBUG) {
    NN__DEBUG_LOG("Floating Nav element created:", floatingNav);
  }

  const floatingFooter = NN_floatElement(NN_footer, "footer", []);

  if (NN_CONFIG.__DEBUG) {
    NN__DEBUG_LOG("Floating Footer element created:", floatingFooter);
  }

  floatingNav.classList.add("NN_shake");
  floatingFooter.classList.add("NN_shake");

  await NN_wait(NN_CONFIG.shakeDuration);

  floatingNav.classList.remove("NN_shake");
  floatingFooter.classList.remove("NN_shake");

  const navTargetX = NN_screenCentre.x - parseInt(floatingNav.style.width) / 2;
  const navTargetY = NN_screenCentre.y - parseInt(floatingNav.style.height) / 2;

  if (NN_CONFIG.__DEBUG) {
    NN__DEBUG_LOG(`Nav Target: (${navTargetX}, ${navTargetY})`);
  }

  const footerTargetX =
    NN_screenCentre.x - parseInt(floatingFooter.style.width) / 2;
  const footerTargetY =
    NN_screenCentre.y - parseInt(floatingFooter.style.height) / 2;

  if (NN_CONFIG.__DEBUG) {
    NN__DEBUG_LOG(`Footer Target: (${footerTargetX}, ${footerTargetY})`);
  }

  NN_moveElement(
    floatingNav,
    navTargetX,
    navTargetY,
    // NN_screenCentre.x,
    // NN_screenCentre.y,
    true
  );
  NN_moveElement(
    floatingFooter,
    footerTargetX,
    footerTargetY,
    // NN_screenCentre.x,
    // NN_screenCentre.y,
    true
  );
}
