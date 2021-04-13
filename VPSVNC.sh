#!bin/bash
x="option"
i="ipvps"
u="uservps"
k="keyvps"
d="display"
t="tswap"
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
echo " 3 - Sair do Script"
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
     echo " Saindo...  "
     sleep 5
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
