#!bin/bash
x="option"
i="ipvps"
u="uservps"
k="keyvps"
d="display"
t="tswap"
y="fxuser"
z="yesno"
menu ()
{
while true do $x !="option"
do
clear
echo "================================================"
echo "Bem Vindo ao Script de Configuração da VPS"
echo ""
echo "Lista de Opções:"
echo " 1 - Instalar Interface Grafica Light ~ VNC"
echo " 2 - Configurar Partição Swap"
echo " 3 - Baixar e Configurar Artefatos do Five M"
echo " 4 - Instalar e Executar XAMPP"
echo " 5 - Sair do Script"
echo ""
echo "================================================"
echo " Digite a opção desejada:"
read x
echo " Opção selecionada: ($x)"
echo "================================================"

case "$x" in

    1)
     echo "================================================"
     echo " Digite o IP da sua VPS:"
     read i
     echo " O IP Informado foi: ($i)"
     echo "================================================"
     echo ""
     echo "================================================"
     echo " Digite o nome de usuario da sua VPS:"
     read u
     echo " O Usuario Informado foi: ($u)"
     echo "================================================"
     echo ""
     echo "==============================================================="
     echo " Digite o nome da chave '.key' que você ira usar para conectar:"
     echo " Exemplo: chave.key"
     read k
     echo " A Chave Informada foi: ($k)"
     echo "==============================================================="
     echo ""
     echo " Instalando Interface Grafica VNC ~ Light"
     echo "Procurando atualizações de pacotes da distro..."
     sudo apt-get update -y
     echo "Busca Finalizada.."
     echo ""
     echo " Atualizando Pacotes da distro..."
     sudo apt-get upgrade -y
     echo "Atualização de pacotes finalizada..."
     echo ""
     echo "Instalando scripts de vnc e editores de texto...."
     sudo apt install tightvncserver xfce4 xfce4-goodies metacity nautilus firefox nano -y
     echo "Instalação finalizada..."
     echo "Iniciando VNC Server"
     vncserver
     echo "Iniciado..."
     echo ""
     echo " Configurando Arquivo: ~/.vnc/xstartup "
     echo ""
     echo " Criando backup do arquivo original xstartup..."
     sudo mv ~/.vnc/xstartup ~/.vnc/xstartup.bkp
     echo "Backup Criado!!"
     echo ""
     echo "Criando novo arquivo xstartup com as linhas necessarias..."
     cd ~/.vnc/
     echo ""
     echo -e '#!/bin/sh \nunset SESSION_MANAGER \nunset DBUS_SESSION_BUS_ADDRESS \nstartxfce4 & \n[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup \n[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources \nxsetroot -solid grey \nvncconfig -iconic & \nmetacity & \nnautilus &' > xstartup
     echo "Arquivo criado com sucesso!!!"
     cd ~/
     echo ""
     echo " Na Sua Localhost abra o painel de conexão ssh e digite a seguinte linha de código:"
     echo " ./ssh.exe -L 5902:localhost:5902 -i $k $u@$i"
     echo " Aguarde 12 Segundos para o script continuar..."
     sleep 12
     echo ""
     echo " Informe o numero do display que você deseja abrir a VNC"
     echo " Exemplo: 1, 2, 3, 4, etc..."
     read d
     echo " Iniciando servidor VNC no diplay $d"
     vncserver -geometry 1024x768 :$d
     echo " Iniciado! Para conectar ao VNC Conecte com o seguinte comando na sua localhost: localhost:$d"
     echo " VNC Configurado e Iniciado com sucesso!!!"
     sleep 2
     echo "=============================================================="
;;
       2)
	 echo " Criando Partição Swap.."
	 echo "Verificando se já existe alguma partição swap:"
	 sudo swapon --show
	 sleep 1
	 echo "Verificando espaço referente a partição swap:"
	 sudo free -h
	 sleep 1
	 echo "Verificando o Espaço Disponível na Partição do Disco Rígido"
	 sudo df -h
	 sleep 2
	 echo "Criando um Arquivo de Swap"
	 echo " Digite o tamanho desejado de swap:"
	 echo " Exemplo: 1G, 2G, 3G, 4G.. Numero:G, o G precisa ser maiusculo!"
	 echo ""
	 read t
	 echo ""
	 sudo fallocate -l $t /swapfile
	 echo ""
	 echo "Verificando se a quantidade correta de espaço foi reservada:"
	 sudo ls -lh /swapfile
	 sleep 2
	 echo ""
	 echo "Habilitando o Arquivo de Swap"
	 sudo chmod 600 /swapfile
	 echo ""
	 echo "Verificando a alteração de permissões:"
	 sudo ls -lh /swapfile
	 sleep 1
	 echo ""
	 echo "Podemos agora marcar o arquivo como espaço de swap:"
	 sudo mkswap /swapfile
	 sleep 1
	 echo ""
	 echo "Após marcar o arquivo, podemos habilitar o arquivo de swap, permitindo que nosso sistema comece a utilizá-lo"
	 sudo swapon /swapfile
	 echo ""
	 echo "Verifique se o swap está disponível:"
	 sudo swapon --show
	 sleep 2
	 echo ""
	 echo "Podemos verificar a saída do utilitário free novamente para corroborar nossos resultados:"
	 sudo free -h
	 sleep 2
	 echo ""
	 echo "Tornando o Arquivo de Swap Permanente.."
	 echo "Fazendo um backup do arquivo /etc/fstab para o caso de algo dar errado:"
	 sudo cp /etc/fstab /etc/fstab.bak
	 echo ""
	 echo "Adicione a informação do arquivo de swap no final do seu arquivo /etc/fstab digitando:"
	 sudo echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
	 echo "Em seguida, avaliaremos algumas configurações que podemos atualizar para ajustar nosso espaço de swap."
	 sleep 3
	 echo ""
	 echo "As Configurações referentes a Swappiness e Cache da Swap,"
	 echo " deverão ser ajustadas de forma manualmente, para evitar problemas,"
	 echo " de acordo com as necessidades de cada um...."
	 echo " Parabéns seu Swap esta configurado! Reinicie e Digite: sudo free -h"
	 echo " Para checar a swap e seu tamanho atual."
	 sleep 1
	 echo "=============================================================="
;;
       3)
	 echo " Bem Vindo as Configurações de instalação do servidor de fivem!"
	 echo " Preencha com as informações corretas sem erros!"
	 echo ""
	 echo " Qual o nome de usuario em que deseja instalar os arquivos?"
	 echo " Atenção! é o nome que fica após /home/ exemplo: /home/ubuntu"
	 echo ""
	 echo " Coloque apenas o nome do usuário sem /home/... Exemplo: ubuntu"
	 read y
	 echo " O Nome de usuário selecionado foi: ($y)"
	 sleep 1
	 echo "Criando pasta FXServer na home do usuario padrão do sistema."
	 mkdir -p /home/$y/FXServer/
	 mkdir -p /home/$y/FXServer/server
	 echo "Pastas criadas!!"
	 echo ""
	 echo " Acesse o link a seguir copie o link de download da ultima versão"
	 echo "https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/"
	 echo "Cole no campo abaixo o link da versão dos artefatos que deseja instalar:"
	 read r
	 echo "Acessando pastas e baixando os artefatos..."
	 cd /home/$y/FXServer/server
	 wget $r
	 echo "Download Completo!!"
	 echo "Iremos checar se você possui o pacote xz-utils para extrair o artefo!"
	 sudo apt-get update
	 sudo apt-get install xz-utils
	 echo "Pacotes instalados/Checados.. Extraindo artefatos!"
	 tar xf fx.tar.xz
	 sleep 1
	 echo "Arquivos extraidos.. excluindo arquivo compactado.."
	 rm -r fx.tar.xz
	 echo " A Seguir escolha as opções do server-data"
	 menu ()
     {
      while true do $z !="yesno"
      do
	  echo " Você deseja baixar o Server-Data disponível do FiveM?"
	  echo " y - sim"
	  echo " n - não"
	  echo " s - sair"
	  echo "Digite a opção desejada:"
	  read z
	  echo "==========================="
	  
	  case "$z" in
	     
		 y)
		   echo "Você escolheu por baixar a server-data do Five M padrão/Inicial"
		   echo ""
		   git clone https://github.com/citizenfx/cfx-server-data.git /home/$y/FXServer/server/server-data
		   echo ""
		   cd /home/$y/FXServer/server/server-data
		   echo "Iniciando o Script de Criação da CFG!!!"
		   sleep 2
		   #!bin/sh
		   ps="portaservidor"
		   nomesv="serverhostname"
		   shk="scripthook"
		   src="senharcon"
		   tgs="tagserver"
		   idsv="idiomasv"
		   pjn="projectname"
		   dcsv="descsv"
		   onesync="onesync"
		   slots="slots"
		   steamkey="steamkey"
		   licensekey"licensekey"

		   echo " Bem Vindo ao Script de Criação da CFG"
		   echo "Desenvolvido por: Cybernetic_Spectre"

		   echo ""
		   echo ""
		   echo "Digite a porta que você ira usar no servidor:"
		   read ps
		   echo '#Porta Do Servidor.' > server.cfg
		   echo endpoint_add_tcp " 0.0.0.0:$ps " >> server.cfg
		   echo endpoint_add_udp " 0.0.0.0:$ps " >> server.cfg
		   echo '' >> server.cfg

		   echo ""
		   echo ""
		   echo "Habilitar ScriptHook no Servidor?"
		   echo " 0 - Para não"
		   echo " 1 - Para sim"
		   read shk
		   echo '#ScriptHook.' >> server.cfg
		   echo sv_scriptHookAllowed $shk >> server.cfg
		   echo '' >> server.cfg

		   echo ""
		   echo ""
		   echo "Digite a senha do rcon, você pode alterar depois:"
		   read src
		   echo '#Senha do Super Admin Rcon' >> server.cfg
		   echo rcon_password " $src " >> server.cfg
		   echo '' >> server.cfg

		   echo ""
		   echo ""
		   echo "Tags do servidor;"
		   echo "Digite separadas apenas por espaço, Exemplos:"
		   echo " default roleplay base whitelist etc etc"
		   read tgs
		   echo '#Tags do Servidor' >> server.cfg
		   echo sets tags " $tgs " >> server.cfg
		   echo '' >> server.cfg

		   echo ""
		   echo ""
		   echo "Digite o Idioma do Servidor:"
		   echo "Exemplos: "en-US", "fr-CA", "nl-NL", "de-DE", "en-GB", "pt-BR""
		   read idsv
		   echo '#Idioma do Servidor' >> server.cfg
		   echo '#Exemplos: "en-US", "fr-CA", "nl-NL", "de-DE", "en-GB", "pt-BR"' >> server.cfg
		   echo sets locale " $idsv " >> server.cfg
		   echo '' >> server.cfg

		   echo ""
		   echo ""
		   echo Banner do Servidor >> server.cfg
		   echo #sets banner_detail "https://url.to/image.png" >> server.cfg
		   echo #sets banner_connecting "https://url.to/image.png" >> server.cfg
		   echo '' >> server.cfg

		   echo ""
		   echo ""
		   echo "Digite o nome do projeto do servidor:"
		   read pjn
		   echo '#Nome do Projeto do Servidor' >> server.cfg
		   echo sets sv_projectName " $pjn " >> server.cfg
		   echo '' >> server.cfg

		   echo ""
		   echo ""
		   echo "Digite a descrição do seu servidor:"
		   read dcsv
		   echo '#Descrição do servidor' >> server.cfg
		   echo sets sv_projectDesc " $dcsv " >> server.cfg
		   echo '' >> server.cfg

		   echo ""
		   echo ""
		   echo '# Nested configs!' >> server.cfg
		   echo '#exec server_internal.cfg' >> server.cfg
		   echo '' >> server.cfg

		   echo ""
		   echo ""
		   echo '#Loading a server icon 96x96 PNG file' >> server.cfg
		   echo 'load_server_icon myLogo.png' >> server.cfg
		   echo '' >> server.cfg

		   echo ""
		   echo ""
		   echo '# convars which can be used in scripts' >> server.cfg
		   echo set temp_convar "hey world!" >> server.cfg
		   echo '' >> server.cfg

		   echo ""
		   echo ""
		   echo '#Listar na master list' >> server.cfg
		   echo #sv_master1 "" >> server.cfg
		   echo '' >> server.cfg

		   echo ""
		   echo ""
		   echo #Add system admins >> server.cfg
		   echo add_ace group.admin command allow >> server.cfg
		   echo add_ace group.admin command.quit deny >> server.cfg
		   echo add_principal identifier.fivem:1 group.admin >> server.cfg
		   echo '' >> server.cfg

		   echo ""
		   echo ""
		   echo "Você quer o onesync on ou off?"
		   echo " on - ligado"
		   echo " off - desligado"
		   read onesync
		   echo '#OneSync On/Off' >> server.cfg
		   echo set onesync $onesync >> server.cfg
		   echo '' >> server.cfg

		   echo ""
		   echo ""
		   echo "Digite a quantidade maxima de Slots do servidor:"
		   read slots
		   echo '#Server player slot limit see https://fivem.net/server-hosting for limits' >> server.cfg
		   echo '#Quantidade Maxima de Slots' >> server.cfg
		   echo sv_maxclients $slots >> server.cfg
		   echo '' >> server.cfg

		   echo ""
		   echo ""
		   echo "Digite o nome do servidor:"
		   read nomesv
		   echo '#Nome do Servidor' >> server.cfg
		   echo sv_hostname " $nomesv " >> server.cfg
		   echo '' >> server.cfg

		   echo ""
		   echo ""
		   echo "Digite sua Steam Api Key"
		   read steamkey
		   echo '#Steam Api Key' >> server.cfg
		   echo set steam_webApiKey $steamkey >> server.cfg
		   echo '' >> server.cfg

		   echo ""
		   echo ""
		   echo "Digite a license Key do seu servidor:"
		   read licensekey
		   echo '#Server LicenseKey' >> server.cfg
		   echo sv_licenseKey $licensekey >> server.cfg

		   echo ""
		   echo ""
		   echo "Os Resources padrão estão sendo inseridos"
		   echo "Caso queira Modificar-los edite manualmente"
		   echo "O Arquivo: server.cfg"
		   echo '' >> server.cfg

		   echo '#######################################' >> server.cfg
		   echo '#Estes Recursos Iniciam como padrão:' >> server.cfg
		   echo 'ensure mapmanager' >> server.cfg
		   echo 'ensure chat' >> server.cfg
		   echo 'ensure spawnmanager' >> server.cfg
		   echo 'ensure sessionmanager' >> server.cfg
		   echo 'ensure basic-gamemode' >> server.cfg
		   echo 'ensure hardcap' >> server.cfg
		   echo 'ensure rconlog' >> server.cfg
		   echo '#######################################' >> server.cfg
		   echo " Tudo Pronto!!!! Iniciaremos seu servidor para teste!"
		   echo " Caso deseje fechar apenas de Ctrl+C"
		   sleep 1
		   clear;
                   exit;
		 echo "======="
		 ;;
		 
		 n)
		   echo " Ok, Fecharemos o script, basta você iniciar o script: run.sh para prosseguir com o start do servidor"
                   echo "Localização: /home/$y/FXServer/server/run.sh "
		   sleep 7
		   clear;
		   exit;
		 echo "======="
		 ;;
		 s)
                  echo " Saindo...  "
                  sleep 1
                  clear;
                  exit;
                 echo "======="
                 ;;
        esac 
        done
      }
      menu
      sleep 2
     echo "=============================================================="
;;
       4)
	 echo " Baixando e Configurando Cliente MySql: XAMPP"
	 echo ""
	 cd ~/
	 echo "Usaremos a versão 8.0.3 Caso precise atualize manualmente."
	 sudo wget https://www.apachefriends.org/xampp-files/8.0.3/xampp-linux-x64-8.0.3-0-installer.run
	 sudo chmod +x xampp-linux-x64-8.0.3-0-installer.run
	 sudo ./xampp-linux-x64-8.0.3-0-installer.run
	 sleep 2
	 sudo rm -r xampp-linux-x64-8.0.3-0-installer.run
	 sudo /opt/lampp/xampp startmysql
	 sleep 2
         echo "=============================================================="
;;
       5)
         echo " Saindo...  "
         sleep 1
         clear;
         exit;
         echo "=============================================================="
;;
*)
echo " Opção inválida! "
esac
done
}
menu
