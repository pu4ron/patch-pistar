#!/bin/bash

#
################################################
#                                              #
#        Por: Ronualdo JSA - PU4RON            #
#                                              #
#                Janauba/MG                    #
#                                              #
################################################
#

clear
echo -e "\033[01;37m****************************************\033[00;37m"
echo -e "\033[01;37m*                                      *\033[00;37m"
echo -e "\033[01;37m*          \033[01;33mRONUALDO - PU4RON\033[00;37m           *"
echo -e "\033[01;37m*                                      *\033[00;37m"
echo -e "\033[01;37m*                 \033[01;33mv1.0    \033[00;37m             *"
echo -e "\033[01;37m*                                      *\033[00;37m"
echo -e "\033[01;37m****************************************\033[00;37m"
echo ""
echo ""


read -p "Deseja continuar? (s/n): " resposta
if [[ "$resposta" != "s" && "$resposta" != "S" ]]; then

  echo ""
  echo "*** Cancelado ***"

  exit 0
fi

echo ""
mount -o remount,rw /

sleep 2

echo "* Um momento..."
echo " "
sudo apt-get install --reinstall procps


SERVICE_FILE="/lib/systemd/system/mmdvmhost.service"

if [ -f "$SERVICE_FILE" ]; then
  
  sudo sed -i '/^ExecStart=/ { /sudo/! s|^ExecStart=|ExecStart=sudo | }' "$SERVICE_FILE"
  sudo sed -i '/^ExecStop=/ { /sudo/! s|^ExecStop=|ExecStop=sudo | }' "$SERVICE_FILE"
  sudo sed -i '/^ExecReload=/ { /sudo/! s|^ExecReload=|ExecReload=sudo | }' "$SERVICE_FILE"

else
  echo "Arquivo $SERVICE_FILE não encontrado!"
fi

echo " "
sleep 2
echo "* Um momento... aguarde!!!"
sudo systemctl daemon-reload

echo "* Reiniciando servicos..."
sudo systemctl restart mmdvmhost.service
sudo systemctl restart dmr2ysf.service
sudo systemctl restart dmrgateway.service

echo " "
echo " "
read -p "Deseja reiniciar o sistema? (s/n): " reboot_choice
if [[ "$reboot_choice" == "s" || "$reboot_choice" == "S" ]]; then
  echo "Reiniciando o sistema..."
  sudo reboot
else
  echo " "
  echo "Nenhuma reboot solicitada. Concluido!!!"
fi
