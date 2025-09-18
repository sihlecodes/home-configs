override INSTALL_DIR = ${HOME}

FILES = .bash_profile \
		  .bashrc \
		  .dircolors \
		  .gitconfig \
		  .inputrc \
		  .tmux.conf \
		  .vimrc

DIRECTORIES = .vim \
				  .bash \
				  .tmux

link: files directories special done

all: link essential-packages done

files:
	@$(foreach file, ${FILES}, [ -e "${INSTALL_DIR}/${file}" ] || [ -h "${INSTALL_DIR}/${file}" ] || ln ${file} ${INSTALL_DIR};)

directories:
	@$(foreach directory, ${DIRECTORIES}, [ -h "${INSTALL_DIR}/${directory}" ] || ln -s ${PWD}/${directory} ${INSTALL_DIR};)


special:
	@[ -h "${INSTALL_DIR}/.config/nvim" ] || ln -s ${PWD}/nvim ${INSTALL_DIR}/.config
	@[ -h "${INSTALL_DIR}/mybin" ] || ln -s ${PWD}/bin ${INSTALL_DIR}/mybin

update:
	@sudo apt update && sudo apt upgrade

node:
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
	\. "${HOME}/.nvm/nvm.sh"; nvm install node

essential-packages: update apt neovim tpm node

apt:
	@sudo apt install tmux build-essential

neovim:
	@sudo snap install --channel edge --classic nvim

tpm:
	@git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

done:
	@echo DONE :D
