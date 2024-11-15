# todo-list

Este é um aplicativo de lista de tarefas desenvolvido em Flutter, permitindo que usuários criem, editem, excluam e alterem o status de suas próprias tarefas (pendente ou concluída). O aplicativo utiliza autenticação com token para garantir que apenas o usuário autenticado possa acessar e manipular suas tarefas. Inclui sincronização em tempo real das tarefas e suporte à localização pt_BR para formatação de datas.

<div style="display: flex; justify-content: space-between;">
  <img src="assets/print01.png" width="400" height="800" />
 <img src="assets/print02.png" width="400" height="800" />
</div>


### Arquitetura e Design

- Arquitetura: Utilizei o padrão MVVM (Model-View-ViewModel) para separar responsabilidades e manter o código organizado.
- Gerenciamento de Estado: Escolhi o Provider por sua simplicidade e integração nativa ao Flutter. Ele permitiu gerenciar operações como adicionar, editar, deletar e sincronizar tarefas em tempo real.
- Backend: Usei o Firebase Realtime Database para sincronização em tempo real, em vez do Firestore, para simplificar a implementação. A principal diferença é que o Realtime Database é baseado em dados hierárquicos, enquanto o Firestore trabalha com documentos e coleções (mais estruturado e escalável para grandes aplicações).

### Do Aplicativo

- Autenticação de Usuário: Implementação de login, cadastro e recuperação de senha usando o Firebase Authentication.
- Gerenciamento de Tarefas: Tarefas podem ser criadas, editadas, excluídas e marcadas como concluídas ou pendentes. Separação clara entre tarefas pendentes e concluídas na interface.
- Sincronização em Tempo Real: Alterações feitas em qualquer dispositivo são refletidas em tempo real usando o Firebase Realtime Database.
- Interface do Usuário: A interface segue o Material Design para garantir uma experiência intuitiva e adaptável a diferentes tamanhos de tela.


### Melhorias Futuras
- Renovação Automática de Sessão: Implementar renovação automática de token no Firebase.
- Notificações Push: Enviar notificações para tarefas com prazo.
- Suporte Offline com Sincronização: Usar armazenamento local para acesso offline e sincronização posterior.
- Filtros Avançados e Ordenação: Adicionar filtros de prioridade, prazos, e ordenação de tarefas.
- Adicionar testes unitários e de widget para aumentar a robustez.
- Implementar o MobX para gerenciamento de estado.
- Migrar para o Firestore para melhorar a estrutura e escalabilidade dos dados.

### Requisitos
- Flutter SDK: Versão 3.x ou superior
- Dart: Versão 2.17 ou superior
- Dependências do Projeto: Listadas no pubspec.yaml

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
