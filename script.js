let notificationCount = 0;
let currentHelpNotification = null;

window.addEventListener('message', function(event) {
    const { type, data } = event.data;
    
    switch(type) {
        case "CREATE_ADVANCED_NOTIFICATION":
            createAdvancedNotification(data);
            break;
        case "CREATE_BASIC_NOTIFICATION":
            createBasicNotification(data);
            break;
        case "CREATE_HELP_NOTIFICATION":
            createHelpNotification(data);
            break;
        case "REMOVE_HELP_NOTIFICATION":
            removeHelpNotification();
            break;
    }
});

// Notification Avancée (code existant renommé)
function createAdvancedNotification(data) {
    const wrapper = document.getElementById('notifications-wrapper');
    const notif = document.createElement('div');
    const id = `notification-${notificationCount++}`;
    
    notif.id = id;
    notif.className = 'notification';
    
    // Appliquer les couleurs personnalisées
    if (data.backgroundColor) notif.style.backgroundColor = data.backgroundColor;
    if (data.borderColor) notif.style.borderLeft = `4px solid ${data.borderColor}`;

    let content = '';
    
    // Ajouter la bannière en arrière-plan si spécifiée
    if (data.banner) {
        content += `<img src="${data.banner}" class="notification-banner">`;
    }
    
    // Ajouter le titre, sous-titre et type
    if (data.title) {
        content += `
            <div>
                <div class="notification-title-row">
                    <div class="notification-title">${data.title}</div>
                    ${data.type ? `<div class="notification-type" style="color: ${data.typeColor || '#fff'}">[${data.type}]</div>` : ''}
                </div>
                ${data.subtitle ? `<div class="notification-subtitle">${data.subtitle}</div>` : ''}
            </div>
        `;
    }
    
    content += '</div>';
    
    // Ajouter la description
    if (data.description) {
        content += `<div class="notification-description">${data.description}</div>`;
    }
    
    content += '</div>';
    
    // Ajouter la barre de progression
    content += `<div id="${id}-progress" class="notification-progress"></div>`;
    
    notif.innerHTML = content;
    wrapper.appendChild(notif);
    
    // Animation d'entrée
    setTimeout(() => {
        notif.classList.add('show');
        const progress = document.getElementById(`${id}-progress`);
        
        // Définir la transition CSS pour qu'elle corresponde à la durée
        progress.style.transition = `width ${data.duration/1000}s linear`;
        progress.style.width = '100%';
        
        // Animation de la barre de progression
        requestAnimationFrame(() => {
            progress.style.width = '0%';
        });
    }, 100);
    
    // Suppression de la notification
    setTimeout(() => {
        notif.classList.remove('show');
        setTimeout(() => {
            notif.remove();
        }, 300);
    }, data.duration);
}

// Notification Simple
function createBasicNotification(data) {
    const wrapper = document.getElementById('notifications-wrapper');
    const notif = document.createElement('div');
    const id = `notification-${notificationCount++}`;
    
    notif.id = id;
    notif.className = 'notification basic-notification';
    
    let content = `
        <div class="notification-content">
            <div class="notification-title-row">
                <div class="notification-title">${data.title || ''}</div>
                ${data.type ? `<div class="notification-type" style="color: ${data.typeColor || '#fff'}">[${data.type}]</div>` : ''}
            </div>
            <div class="notification-message">${data.message || ''}</div>
            <div id="${id}-progress" class="notification-progress" style="background-color: ${data.progressColor || '#6b2ecc'}"></div>
        </div>
    `;
    
    notif.innerHTML = content;
    wrapper.appendChild(notif);
    
    // Animation d'entrée
    setTimeout(() => {
        notif.classList.add('show');
        const progress = document.getElementById(`${id}-progress`);
        progress.style.transition = `width ${data.duration/1000}s linear`;
        progress.style.width = '100%';
        requestAnimationFrame(() => {
            progress.style.width = '0%';
        });
    }, 100);
    
    if (data.duration > 0) {
        setTimeout(() => {
            notif.classList.remove('show');
            setTimeout(() => notif.remove(), 300);
        }, data.duration);
    }
}

// Notification d'aide
function createHelpNotification(data) {
    removeHelpNotification(); // Retire l'ancienne notification d'aide si elle existe
    
    const wrapper = document.createElement('div');
    wrapper.id = 'help-notification';
    wrapper.className = 'help-notification';
    
    wrapper.innerHTML = `
        <div class="help-key">${data.key}</div>
        <div class="help-message">${data.message}</div>
    `;
    
    document.body.appendChild(wrapper);
    currentHelpNotification = wrapper;
    
    setTimeout(() => wrapper.classList.add('show'), 100);
    
    if (data.duration > 0) {
        setTimeout(() => removeHelpNotification(), data.duration);
    }
}

function removeHelpNotification() {
    if (currentHelpNotification) {
        currentHelpNotification.classList.remove('show');
        setTimeout(() => {
            currentHelpNotification.remove();
            currentHelpNotification = null;
        }, 300);
    }
}
