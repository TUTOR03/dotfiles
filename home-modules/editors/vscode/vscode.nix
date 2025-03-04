{ config, pkgs, lib, ... }:

{
  options = {
    vscode.enable = lib.mkEnableOption "enables VSCode";
  };

  config = lib.mkIf config.vscode.enable {
    programs.vscode = {
      enable = true;

      extensions = with pkgs.vscode-extensions; [
        # Языки и фреймворки
        golang.go # Go
        rust-lang.rust-analyzer # Rust
        ms-python.python # Python
        ms-python.vscode-pylance # Python (Pylance)
        vue.volar # Vue
        svelte.svelte-vscode # Svelte
        astro-build.astro-vscode # Astro
        prisma.prisma # Prisma

        # Инструменты разработки
        dbaeumer.vscode-eslint # ESLint
        esbenp.prettier-vscode # Prettier
        stylelint.vscode-stylelint # Stylelint
        ms-azuretools.vscode-docker # Docker
        ms-vscode.makefile-tools # Makefile
        redhat.vscode-yaml # YAML
        tamasfe.even-better-toml # TOML
        slevesque.shader # Shader
        racczzalan.webgl-glsl-editor # WebGL GLSL
        vadimcn.vscode-lldb # LLDB (отладка C/C++/Rust)
        probe-rs.probe-rs-debugger # Probe-rs (отладка Rust для embedded)

        # Git и GitHub
        eamodio.gitlens # GitLens
        mhutchie.git-graph # Git Graph
        me-dutour-mathieu.vscode-github-actions # GitHub Actions

        # UI и иконки
        pkief.material-icon-theme # Material Icon Theme
        wix.vscode-import-cost # Import Cost (размер импортов)
        yoavbls.pretty-ts-errors # Pretty TypeScript Errors

        # Дополнительные инструменты
        adpyke.codesnap # CodeSnap (скриншоты кода)
        adpyke.vscode-sql-formatter # SQL Formatter
        davidanson.vscode-markdownlint # Markdown Lint
        ms-vscode.hexeditor # Hex Editor
        ms-vsliveshare.vsliveshare # Live Share
        rangav.vscode-thunder-client # Thunder Client (HTTP-клиент)
        yzane.markdown-pdf # Markdown to PDF
        medo64.render-crlf # Render CRLF
        mkxml.vscode-filesize # File Size
        lior-chamla.google-fonts # Google Fonts
      ];
    };

    home.file.".config/Code/User/settings.json".source = ./vscode/settings.json;
    home.file.".config/Code/User/keybindings.json".source = ./vscode/keybindings.json;
  };
}