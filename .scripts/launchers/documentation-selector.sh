#!/bin/bash
# Mikey Garcia, @gikeymarcia
# dmenu quick selector for documentation I use frequently
# dependencies: dmenu
# environment: $DMENU_FONT $DMENU_COLORS $BROWSER

docs+=("Pandas             https://pandas.pydata.org/docs/")
docs+=("Ansible-authorized_key       https://docs.ansible.com/ansible/2.9/modules/authorized_key_module.html")
docs+=("Ansible-Copy       https://docs.ansible.com/ansible/2.9/modules/copy_module.html#copy-module")
docs+=("Ansible-Debconf    https://docs.ansible.com/ansible/2.9/modules/debconf_module.html")
docs+=("Ansible-File       https://docs.ansible.com/ansible/2.9/modules/file_module.html#file-module")
docs+=("Ansible-get_url    https://docs.ansible.com/ansible/2.9/modules/get_url_module.html")
docs+=("Ansible-User       https://docs.ansible.com/ansible/2.9/modules/user_module.html#user-module")
docs+=("Ansible-Package    https://docs.ansible.com/ansible/2.9/modules/package_module.html#package-module")
docs+=("Ansible-systemd    https://docs.ansible.com/ansible/2.9/modules/systemd_module.html")
docs+=("Ansible-service    https://docs.ansible.com/ansible/2.9/modules/service_module.html")
docs+=("Ansible-pip        https://docs.ansible.com/ansible/2.9/modules/pip_module.html#pip-module")
docs+=("Ansible-dnf        https://docs.ansible.com/ansible/2.9/modules/dnf_module.html#dnf-module")
docs+=("Ansible-apt        https://docs.ansible.com/ansible/2.9/modules/apt_module.html#apt-module")
docs+=("Ansible-AllModules https://docs.ansible.com/ansible/2.9/modules/modules_by_category.html")
docs+=("Ansible-Config     https://docs.ansible.com/ansible/2.9/reference_appendices/config.html")
docs+=("Pango-markup       https://developer.gnome.org/pygtk/stable/pango-markup-language.html")
docs+=("Qtile--Keys        http://docs.qtile.org/en/latest/manual/config/keys.html?highlight=keys")
docs+=("Qtile--widgets     http://docs.qtile.org/en/latest/manual/ref/widgets.html")
docs+=("Qtile--layouts     http://docs.qtile.org/en/latest/manual/ref/layouts.html#")
docs+=("Watson--commands   https://tailordev.github.io/Watson/user-guide/commands/")
docs+=("AwesomeWM          https://awesomewm.org/doc/api/")
docs+=("AwesomeWM--screen  https://awesomewm.org/doc/api/classes/screen.html#")
docs+=("AwesomeWM--client  https://awesomewm.org/doc/api/classes/client.html")
docs+=("AwesomeWM--tag     https://awesomewm.org/doc/api/classes/tag.html")
docs+=("citeproc--CSL-Json https://citeproc-js.readthedocs.io/en/latest/csl-json/markup.html")
docs+=("Lubuntu--manual    https://manual.lubuntu.me/stable/")

list_docs () {
    for d in "${docs[@]}"; do echo "$d"; done
}

# shellcheck disable=2086
link=$(list_docs | dmenu -i -l 20 \
    -fn "$DMENU_FONT" $DMENU_COLORS -p "Which documentation?")
if [ -n "$link" ]; then
    echo "$link"
    url=$(printf "%s" "$link" | awk '{print $2}')
    $BROWSER "$url"
fi
