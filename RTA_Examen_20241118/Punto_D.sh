#!/bin/bash

echo "Preparando archivos y configuraciones para el role"

echo "Información del sistema:"
ifconfig | grep "inet " | awk '{print $2}'
lsb_release -a
echo "Cantidad de cores: $(nproc)"

mkdir -p files
cd files || exit 1

echo "Nombre: Emiliano" > datos_alumno.txt
echo "Apellido: García" >> datos_alumno.txt
echo "División: 115" >> datos_alumno.txt

echo "IP: 192.168.56.3" > datos_equipo.txt
echo "Distributor ID: Ubuntu" >> datos_equipo.txt
echo "Description:    Ubuntu 22.04.4 LTS" >> datos_equipo.txt
echo "Release:        22.04" >> datos_equipo.txt
echo "Codename:       jammy" >> datos_equipo.txt
echo "Cantidad de cores: 2" >> datos_equipo.txt

echo "Archivos txt creados en el directorio 'files'."

cd ../roles/2do_parcial/tasks || exit 1
cat > main.yml <<EOL
---
- debug:
    msg: "Tareas del 2do Parcial"

- name: Crear directorios alumno y equipo
  file:
    path: "/tmp/2do_parcial/{{ item }}"
    state: directory
    mode: '0755'
  loop:
    - alumno
    - equipo
  become: true

- name: Copiar archivo datos_alumno.txt
  copy:
    src: "../../files/datos_alumno.txt"
    dest: "/tmp/2do_parcial/alumno/datos_alumno.txt"
  become: true

- name: Copiar archivo datos_equipo.txt
  copy:
    src: "../../files/datos_equipo.txt"
    dest: "/tmp/2do_parcial/equipo/datos_equipo.txt"
  become: true

- name: Configurar sudoers para el grupo 2PSupervisores
  ansible.builtin.lineinfile:
    path: /etc/sudoers.d/2p_supervisores
    state: present
    create: yes
    mode: '0440'
    line: '%2PSupervisores ALL=(ALL) NOPASSWD: ALL'
  become: true
EOL

echo "Archivo main.yml configurado para el role."

cd ../../..
ansible-playbook -i inventory playbook.yml

echo "Ejecución del playbook finalizada."
