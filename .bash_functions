# Simple note taking utilities
# Based on https://news.ycombinator.com/item?id=17798373
umedit() { mkdir -p ~/.notes; vim ~/.notes/"$1"; }
um() { less ~/.notes/"$1"; }
umls() { ls ~/.notes; }

# Fuzzy finder for Ansible playbook/inventory
# files to cut down on typing
function apz()
{
  if [ -d "playbooks" ]
  then  pbk=$(ls playbooks | fzf --prompt="Playbook: ")
  fi

  if [ -d "inventory" ]
  then inv=$(ls inventory | fzf --prompt="Inventory: ")
  fi

  ansible-playbook playbooks/$pbk -i inventory/$inv/hosts.yml
}
