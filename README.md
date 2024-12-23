# Système de Notifications FiveM

Un système de notifications moderne, flexible et responsive pour FiveM, compatible avec ESX.

## 📋 Caractéristiques

- 3 types de notifications :
  - Notifications avancées (avec bannière et icône)
  - Notifications basiques
  - Notifications d'aide (style ShowHelpNotification)
- Entièrement compatible ESX
- Design responsive
- Animations fluides
- Personnalisable
- Utilisable côté client et serveur


## 🎨 Codes Couleurs Recommandés

Types de notifications prédéfinis :
- Succès : `#53cc2e`
- Erreur : `#cc2e2e`
- Information : `#3498db`
- Attention : `#f1c40f`

## 📏 Dimensions Recommandées pour les Images

- Bannières : 800x200 pixels
- Icônes : 64x64 pixels

## ⚙️ Personnalisation

Le style des notifications peut être modifié dans le fichier `style.css`. Les principaux éléments personnalisables sont :

- `.notification` : Style général des notifications
- `.notification-banner` : Style des bannières
- `.notification-title` : Style des titres
- `.notification-description` : Style des descriptions
- `.help-notification` : Style des notifications d'aide

## ⚠️ Notes Importantes

1. Les chemins des images doivent être relatifs au dossier de la ressource
2. La durée est en millisecondes (5000 = 5 secondes)
3. Pour les notifications d'aide permanentes, utilisez `duration = -1`
4. Les bannières et icônes sont optionnelles pour les notifications avancées

## 🔧 Dépendances

- ESX
- FiveM

## 🐛 Débogage

Si les notifications ne s'affichent pas :
1. Vérifiez que la ressource est démarrée dans le `server.cfg`
2. Vérifiez les chemins des images
3. Ouvrez la console F8 pour voir les éventuelles erreurs
4. Vérifiez que les dossiers `images/banners/` et `images/icons/` existent

## 📄 Licence

Ce projet est sous licence MIT. Vous êtes libre de l'utiliser et de le modifier comme bon vous semble.

## 🛠️ Installation

1. Copiez le dossier dans votre dossier `resources`
2. Ajoutez `ensure nom_de_la_resource` dans votre `server.cfg`
3. Créez les dossiers suivants dans le dossier `images/` :
   ```
   images/
   ├── banners/
   └── icons/
   ```

## 📚 Utilisation

### Côté Client

#### 1. Notification Avancée

```lua
exports['nom_de_la_resource']:ShowAdvancedNotification({
    title = "Titre",
    subtitle = "Sous-titre",
    description = "Description",
    duration = 5000, -- Durée en ms
    icon = "images/icons/logo.png",
    banner = "images/banners/banner.png",
    backgroundColor = "rgba(26, 26, 26, 0.95)",
    progressColor = "#53cc2e",
    type = "Succès",
    typeColor = "#53cc2e"
})
```

#### 2. Notification Basique

```lua
exports['nom_de_la_resource']:ShowBasicNotification({
    title = "Information",
    message = "Message simple",
    duration = 5000,
    type = "Info",
    typeColor = "#3498db",
    progressColor = "#3498db"
})
```

#### 3. Notification d'Aide

```lua
-- Afficher
exports['nom_de_la_resource']:ShowHelpNotification({
    message = "Appuyez sur E pour interagir",
    key = "E",
    duration = -1 -- -1 pour permanent
})
-- Retirer
exports['nom_de_la_resource']:RemoveHelpNotification()
```

### Côté Serveur

#### 1. Notification Avancée

```lua
    exports['nom_de_la_resource']:SendAdvancedNotification(source, {
    title = "Titre",
    subtitle = "Sous-titre",
    description = "Description",
    duration = 5000,
    icon = "images/icons/logo.png",
    banner = "images/banners/banner.png",
    backgroundColor = "rgba(26, 26, 26, 0.95)",
    progressColor = "#53cc2e",
    type = "Succès",
    typeColor = "#53cc2e"
})
``` 

#### 2. Notification Basique

```lua
exports['nom_de_la_resource']:SendBasicNotification(source, {
    title = "Information",
    message = "Message simple",
    duration = 5000,
    type = "Info",
    typeColor = "#3498db",
    progressColor = "#3498db"
})
```

#### 3. Notification d'Aide

```lua
exports['nom_de_la_resource']:SendHelpNotification(source, {
    message = "Appuyez sur E pour interagir",
    key = "E"
})
``` 


