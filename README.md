# todo-list

This is a task list app built with Flutter, allowing users to create, edit, delete, and update the status of their tasks (pending or completed). The app uses token-based authentication to ensure only authenticated users can access and manage their tasks. It features real-time task synchronization and pt_BR localization support for date formatting.

<div style="display: flex; justify-content: space-between;">
  <img src="assets/print01.png" width="400" height="800" />
 <img src="assets/print02.png" width="400" height="800" />
</div>


### Architecture and Design

- Architecture: Implemented the MVVM (Model-View-ViewModel) pattern to separate concerns and maintain organized code.
- State Management: Used Provider for its simplicity and native integration with Flutter, enabling operations like adding, editing, deleting, and real-time task synchronization.
- Backend: Leveraged Firebase Realtime Database for real-time synchronization instead of Firestore to simplify implementation. Unlike Firestore, which uses a document-collection structure for scalability, Realtime Database is based on hierarchical data.

### DAbout the App

- User Authentication: Includes login, registration, and password recovery using Firebase Authentication.
- Task Management: Tasks can be created, edited, deleted, and marked as completed or pending, with a clear separation between pending and completed tasks in the interface.
- Real-Time Synchronization: Changes made on any device are instantly reflected using Firebase Realtime Database.
- User Interface: The UI follows Material Design principles to ensure an intuitive experience and adaptability across different screen sizes.

### Future Improvements

- Automatic Session Renewal: Implement automatic token renewal with Firebase.
- Push Notifications: Send reminders for tasks with deadlines.
- Offline Support with Sync: Implement local storage for offline access and later synchronization.
- Advanced Filters and Sorting: Add filters for priority, deadlines, and task sorting options.
- Unit and Widget Testing: Introduce unit and widget tests to enhance robustness.
- State Management with MobX: Transition to MobX for state management.
- Migration to Firestore: Upgrade to Firestore for better data structure and scalability.

### Requirements

- Flutter SDK: Version 3.x or higher
- Dart: Version 2.17 or higher
- Project Dependencies: Listed in pubspec.yaml

### Instruções de Configuração e Execução
1. Clone o Repositório:

```bash
git clone https://github.com/taisbronca/todo-list
cd todo
```
2. Instale as Dependências: Execute o comando abaixo para instalar todas as dependências listadas no pubspec.yaml:
```bash
flutter pub get
```

3. Configuração do Firebase:

- Acesse o Console do Firebase e crie um novo projeto.
- No painel do Firebase, navegue até Build > Realtime Database e clique em "Criar Banco de Dados". Siga as instruções para configurar o Realtime Database.
- Ainda no painel do Firebase, vá até Authentication e habilite o provedor de e-mail/senha para permitir a autenticação de usuários.

4. Execute o Projeto: 
- Com o Firebase configurado e as dependências instaladas, você pode executar o aplicativo em um dispositivo emulador ou físico:
```bash
flutter run
```

5. Configuração de Segurança (Opcional, mas Recomendado):

No Console do Firebase, em Realtime Database > Regras, defina regras de acesso apropriadas para garantir a segurança dos dados. Por exemplo, para permitir que apenas usuários autenticados leiam e gravem dados, você pode configurar as regras como:
```json
{
  "rules": {
    ".read": "auth != null",
    ".write": "auth != null"
  }
}
```

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

###### tags: `flutter` `dart` `mobile` `firebase`
