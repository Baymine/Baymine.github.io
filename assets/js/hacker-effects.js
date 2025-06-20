// Hacker-style interactive effects

document.addEventListener('DOMContentLoaded', function() {
    // Only run on homepage
    if (!document.querySelector('.hacker-homepage')) return;

    // Matrix rain effect
    createMatrixRain();
    
    // Typing animation for commands
    initTypingAnimations();
    
    // Random glitch effects
    initGlitchEffects();
    
    // Terminal cursor blinking
    initCursorBlink();
    
    // Konami code easter egg
    initKonamiCode();
});

// Matrix rain background effect
function createMatrixRain() {
    const canvas = document.createElement('canvas');
    canvas.className = 'matrix-bg';
    document.body.appendChild(canvas);
    
    const ctx = canvas.getContext('2d');
    
    function resizeCanvas() {
        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;
    }
    
    resizeCanvas();
    window.addEventListener('resize', resizeCanvas);
    
    const chars = '01アイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワヲン';
    const charArray = chars.split('');
    
    const fontSize = 14;
    const columns = canvas.width / fontSize;
    const drops = [];
    
    for (let i = 0; i < columns; i++) {
        drops[i] = 1;
    }
    
    function draw() {
        ctx.fillStyle = 'rgba(10, 10, 10, 0.04)';
        ctx.fillRect(0, 0, canvas.width, canvas.height);
        
        ctx.fillStyle = '#00ff41';
        ctx.font = fontSize + 'px Fira Code, monospace';
        
        for (let i = 0; i < drops.length; i++) {
            const text = charArray[Math.floor(Math.random() * charArray.length)];
            ctx.fillText(text, i * fontSize, drops[i] * fontSize);
            
            if (drops[i] * fontSize > canvas.height && Math.random() > 0.975) {
                drops[i] = 0;
            }
            drops[i]++;
        }
    }
    
    setInterval(draw, 35);
}

// Typing animation for terminal commands
function initTypingAnimations() {
    const commands = document.querySelectorAll('.command');
    
    commands.forEach((cmd, index) => {
        const text = cmd.textContent;
        cmd.textContent = '';
        cmd.style.borderRight = '2px solid #00ff41';
        
        setTimeout(() => {
            typeText(cmd, text, 100);
        }, index * 2000);
    });
}

function typeText(element, text, speed) {
    let i = 0;
    const timer = setInterval(() => {
        if (i < text.length) {
            element.textContent += text.charAt(i);
            i++;
        } else {
            clearInterval(timer);
            element.style.borderRight = 'none';
        }
    }, speed);
}

// Random glitch effects on hover
function initGlitchEffects() {
    const glitchElements = document.querySelectorAll('.skill-tag, .nav-link');
    
    glitchElements.forEach(element => {
        element.addEventListener('mouseenter', () => {
            if (Math.random() > 0.7) {
                element.classList.add('glitch');
                element.setAttribute('data-text', element.textContent);
                
                setTimeout(() => {
                    element.classList.remove('glitch');
                }, 500);
            }
        });
    });
}

// Enhanced cursor blinking
function initCursorBlink() {
    const cursor = document.querySelector('.cursor');
    if (cursor) {
        setInterval(() => {
            cursor.style.opacity = cursor.style.opacity === '0' ? '1' : '0';
        }, 500);
    }
}

// Konami code easter egg
function initKonamiCode() {
    const konamiCode = [
        'ArrowUp', 'ArrowUp', 'ArrowDown', 'ArrowDown',
        'ArrowLeft', 'ArrowRight', 'ArrowLeft', 'ArrowRight',
        'KeyB', 'KeyA'
    ];
    
    let userInput = [];
    
    document.addEventListener('keydown', (e) => {
        userInput.push(e.code);
        
        if (userInput.length > konamiCode.length) {
            userInput.shift();
        }
        
        if (userInput.length === konamiCode.length) {
            if (userInput.every((key, index) => key === konamiCode[index])) {
                activateHackerMode();
                userInput = [];
            }
        }
    });
}

// Easter egg: Activate extreme hacker mode
function activateHackerMode() {
    // Add intense glitch effect to the whole page
    document.body.style.animation = 'glitch-1 0.1s infinite';
    
    // Change all text to green
    document.body.style.color = '#00ff41';
    
    // Add matrix rain overlay
    const overlay = document.createElement('div');
    overlay.style.cssText = `
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 255, 65, 0.1);
        pointer-events: none;
        z-index: 9999;
        animation: blink 0.1s infinite;
    `;
    document.body.appendChild(overlay);
    
    // Show hacker message
    const message = document.createElement('div');
    message.innerHTML = `
        <div style="
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: rgba(0, 0, 0, 0.9);
            color: #00ff41;
            padding: 20px;
            border: 2px solid #00ff41;
            border-radius: 8px;
            font-family: 'Fira Code', monospace;
            text-align: center;
            z-index: 10000;
            box-shadow: 0 0 50px rgba(0, 255, 65, 0.5);
        ">
            <h2>🚨 HACKER MODE ACTIVATED 🚨</h2>
            <p>Welcome to the Matrix, Neo...</p>
            <p>You've unlocked the secret developer mode!</p>
            <button onclick="this.parentElement.parentElement.remove(); document.body.style.animation = ''; document.querySelector('div[style*=\"rgba(0, 255, 65, 0.1)\"]').remove();" 
                    style="
                        background: transparent;
                        color: #00ff41;
                        border: 1px solid #00ff41;
                        padding: 10px 20px;
                        margin-top: 10px;
                        cursor: pointer;
                        font-family: 'Fira Code', monospace;
                    ">
                [EXIT MATRIX]
            </button>
        </div>
    `;
    document.body.appendChild(message);
    
    // Auto-remove after 10 seconds
    setTimeout(() => {
        if (message.parentElement) {
            message.remove();
            overlay.remove();
            document.body.style.animation = '';
        }
    }, 10000);
}

// Terminal command simulation
function simulateTerminalCommand(command, output) {
    const terminalContent = document.querySelector('.terminal-content');
    
    // Add new command line
    const commandLine = document.createElement('div');
    commandLine.className = 'terminal-line';
    commandLine.innerHTML = `
        <span class="prompt">root@baymine:~#</span>
        <span class="command">${command}</span>
    `;
    terminalContent.appendChild(commandLine);
    
    // Add output
    setTimeout(() => {
        const outputDiv = document.createElement('div');
        outputDiv.innerHTML = output;
        outputDiv.style.color = '#00cc33';
        outputDiv.style.marginLeft = '20px';
        terminalContent.appendChild(outputDiv);
        
        // Scroll to bottom
        terminalContent.scrollTop = terminalContent.scrollHeight;
    }, 1000);
}

// Add click handlers for interactive elements
document.addEventListener('click', (e) => {
    if (e.target.classList.contains('skill-tag')) {
        const skill = e.target.textContent;
        simulateTerminalCommand(
            `grep -r "${skill}" /var/log/experience.log`,
            `Found ${Math.floor(Math.random() * 100) + 50} references to ${skill} in experience logs.`
        );
    }
});

// Add some random terminal activity
setInterval(() => {
    if (Math.random() > 0.95 && document.querySelector('.hacker-homepage')) {
        const activities = [
            'Monitoring system processes...',
            'Scanning for vulnerabilities...',
            'Optimizing database queries...',
            'Analyzing network traffic...',
            'Compiling latest changes...'
        ];
        
        const activity = activities[Math.floor(Math.random() * activities.length)];
        console.log(`%c[SYSTEM] ${activity}`, 'color: #00ff41; font-family: monospace;');
    }
}, 5000);
