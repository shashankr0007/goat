/* ============================================
   Carbon Footprint Calculator — main.js
   ============================================ */

document.addEventListener('DOMContentLoaded', function () {

    // ---- Diet card selection highlight ----
    const dietOptions = document.querySelectorAll('.diet-option input[type="radio"]');
    dietOptions.forEach(function (radio) {
        radio.addEventListener('change', function () {
            dietOptions.forEach(function (r) {
                r.closest('.diet-option').querySelector('.diet-box').style.transform = '';
            });
            if (this.checked) {
                this.closest('.diet-option').querySelector('.diet-box').style.transform = 'scale(1.03)';
            }
        });
        // Apply to already-checked on load
        if (radio.checked) {
            radio.closest('.diet-option').querySelector('.diet-box').style.transform = 'scale(1.03)';
        }
    });

    // ---- Number input: prevent negatives via keyboard ----
    document.querySelectorAll('input[type="number"]').forEach(function (inp) {
        inp.addEventListener('blur', function () {
            if (parseFloat(this.value) < 0) this.value = 0;
        });
    });

    // ---- Animate progress bars on result page ----
    const bars = document.querySelectorAll('.bar-fill');
    if (bars.length > 0) {
        // Briefly set to 0 then restore to trigger CSS transition
        bars.forEach(function (bar) {
            const target = bar.style.width;
            bar.style.width = '0%';
            setTimeout(function () { bar.style.width = target; }, 120);
        });

        // Animate score number counting up
        const scoreEl = document.querySelector('.score-number');
        if (scoreEl) {
            const target = parseFloat(scoreEl.textContent);
            let current = 0;
            const step = target / 40;
            const timer = setInterval(function () {
                current += step;
                if (current >= target) { current = target; clearInterval(timer); }
                scoreEl.textContent = current.toFixed(2);
            }, 20);
        }
    }

    // ---- Form validation ----
    const form = document.getElementById('calcForm');
    if (form) {
        form.addEventListener('submit', function (e) {
            const userName = document.getElementById('userName');
            if (userName && userName.value.trim() === '') {
                userName.value = 'Anonymous';
            }
            const submitBtn = form.querySelector('.btn-submit');
            if (submitBtn) {
                submitBtn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Calculating...';
                submitBtn.disabled = true;
            }
        });
    }

});
