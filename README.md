# SETUP TERMINAL

### Homebrew

1. Se você ainda não tiver o Homebrew instalado, você pode instalá-lo com o seguinte comando:

`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

### Xcodegen

1. Gerar arquivos de projeto:

`xcodegen generate`

### Podfile

1. Se necessário, iniciar o gerenciador de dependências:

`pod init`

2. Baixar dependências listadas:

`pod install`

### Swiftgen

1. Instalar o SwiftGen com o seguinte comando:

`brew install swiftgen`

2. Depois que a instalação for concluída, execute o comando **swiftgen config**:

`swiftgen config`

# SETUP IDE

1. Em **TARGETS** -> **Build Phases** -> **SwiftGen**, comente com `#` o seguinte código:

`${PODS_ROOT}/SwiftGen/bin/swiftgen`
