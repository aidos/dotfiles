.PHONY: all install link neovim claude clean
.DEFAULT_GOAL := install

install: packages ~/.local/bin/uv ~/.nvm /usr/local/bin/nvim link claude

packages:
	@echo "Installing packages..."
	sudo apt update
	sudo apt install -y htop tmux curl unzip tree ripgrep

~/.local/bin/uv:
	@echo "Installing uv..."
	curl -LsSf https://astral.sh/uv/install.sh | sh


~/.nvm:
	@echo "Installing nvm and Node.js..."
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
	@echo "Installing Node.js LTS..."
	bash -c 'source ~/.nvm/nvm.sh && nvm install --lts'

# Neovim installation and configuration
/usr/local/bin/nvim: | packages ~/.nvm ~/.config/nvim/init.lua
	@echo "Installing Neovim..."
	curl -LO https://github.com/neovim/neovim/releases/download/v0.11.4/nvim-linux-arm64.appimage && \
	chmod +x nvim-linux-arm64.appimage && \
	sudo mv nvim-linux-arm64.appimage /usr/local/bin/nvim;
	@echo "Setting up Neovim alternatives..."
	@sudo update-alternatives --install /usr/bin/ex ex /usr/local/bin/nvim 110 || true
	@sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/nvim 110 || true
	@sudo update-alternatives --install /usr/bin/view view /usr/local/bin/nvim 110 || true
	@sudo update-alternatives --install /usr/bin/vim vim /usr/local/bin/nvim 110 || true
	@sudo update-alternatives --install /usr/bin/vimdiff vimdiff /usr/local/bin/nvim 110 || true
	@sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/nvim 110 || true
	@sudo update-alternatives --set ex /usr/local/bin/nvim || true
	@sudo update-alternatives --set vi /usr/local/bin/nvim || true
	@sudo update-alternatives --set view /usr/local/bin/nvim || true
	@sudo update-alternatives --set vim /usr/local/bin/nvim || true
	@sudo update-alternatives --set vimdiff /usr/local/bin/nvim || true
	@sudo update-alternatives --set editor /usr/local/bin/nvim || true

~/.config/nvim/init.lua:
	@echo "Linking Neovim config..."
	mkdir -p ~/.config/nvim
	ln -sf ~/.dotfiles/init.lua ~/.config/nvim/init.lua

link:
	@echo "Linking dotfiles..."
	mkdir -p ~/.ssh ~/bin ~/.config/opencode
	ln -sf ~/.dotfiles/_ssh/rc ~/.ssh/rc
	ln -sf ~/.dotfiles/_tmux.conf ~/.tmux.conf
	cp ~/.dotfiles/_gitconfig ~/.gitconfig
	ln -sf ~/.dotfiles/_inputrc ~/.inputrc
	ln -sf ~/.dotfiles/bin/ak_git_clean_slate ~/bin/ak_git_clean_slate
	ln -sf ~/.dotfiles/_opencode.json ~/.config/opencode/opencode.json

claude: | ~/.nvm
	@echo "Installing Claude Code..."
	@if ! bash -c 'source ~/.nvm/nvm.sh && which claude >/dev/null 2>&1'; then \
		bash -c 'source ~/.nvm/nvm.sh && npm install -g @anthropic-ai/claude-code'; \
	else \
		echo "Claude Code already installed at $$(bash -c 'source ~/.nvm/nvm.sh && which claude')"; \
	fi

all: install

clean:
	@echo "Nothing to clean"
