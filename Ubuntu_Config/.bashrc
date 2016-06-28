# Dev Tools bashrc
#source /other/workspace/DeveloperTools/dotfiles/.bashrc

# Vecna Software Exports/Sources
export NEXUS_PATH=/other/workspace/nexus/platform

export NRV_QCBOT_PATH=/other/workspace/nrv/qcbot
export NRV_6DOF_PATH=/other/workspace/nrv/6dof
export NRV_RPR_PATH=/other/workspace/nrv/rpr
export NRV_CORE_PATH=/other/workspace/nrv/core
export NRV_PATH=/other/workspace/nrv
ROS_MASTER_URI=http://localhost:11311
PATH=$NRV_QCBOT_PATH/scripts:$PATH

#VROS bash additions
export VROS_PATH=/other/workspace/vros
kver=$(uname -r)
if [ -d /opt/ros/fuerte ] ; then
    source $VROS_PATH/setup.bash
else
    source $VROS_PATH/devel/setup.bash
fi

export MAVENREPO_PATH=/other/maven/mavenRepository
export ROS_WORKSPACE=$VROS_PATH
export ROS_MAVEN_DEPLOYMENT_REPOSITORY=$MAVENREPO_PATH
export ROS_MAVEN_PATH=$ROS_MAVEN_DEPLOYMENT_REPOSITORY:$ROS_MAVEN_PATH
export ROS_MAVEN_REPOSITORY=http://nexus.crl.vecna.com:8081/nexus/content/repositories/releases
export ROS_SHARE_PATH=$ROS_WORKSPACE/devel/share:$ROS_PACKAGE_PATH
export RLS_PATH=/other/workspace/rls
export GAZEBO_MODEL_PATH=$VROS_PATH/src/original/vurdf:$VROS_PATH/src/original/vlaunch/config/models
export ROS_LANG_DISABLE=genlisp
export ROBOT_SERVICES_HOST=localhost


export CATALINA_HOME=/other/tomcat
export CATALINA_PID=$CATALINA_HOME/PID
export JAVA_OPTS="-server -Xmx1024m -Xms512m -XX:MaxPermSize=512m"
export KIOSK_PATH=/other/workspace/kiosk-platform
export USERADMIN_PATH=/other/workspace/useradminWebapp
export VCAS_PATH=/other/workspace/vCas
export TOMCAT_HOME=/other/tomcat

#perception path variables
export PERCEPTION_KIT_PATH=/other/workspace/perception/perception_kit
export INCLUDE_PATH=/usr/include/eigen3:/opt/ros/fuerte/include:/opt/ros/fuerte/include/opencv
export CPATH=$CPATH:$INCLUDE_PATH
export C_INCLUDE_PATH=$INCLUDE_PATH:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=$INCLUDE_PATH:$CPLUS_INCLUDE_PATH

export ROS_HOME=/other/logs/.ros

#NRV Path variables
export ROS_MASTER_URI=http://localhost:11311
PATH=$NRV_QCBOT_PATH/scripts:/usr/share/gradle-2.1/bin:$PATH

_dir_chomp () {
    local p=${1/#$HOME/\~} b s
    s=${#p}
    while [[ $p != "${p//\/}" ]]&&(($s>$2))
    do
        p=${p#/}
        [[ $p =~ \.?. ]]
        b=$b/${BASH_REMATCH[0]}
        p=${p#*/}
        ((s=${#b}+${#p}))
    done
    echo ${b/\/~/\~}${b+/}$p
}

source ~/.git-completion.bash
source ~/.git-prompt.sh
export PS1='\[\e[1;31m\][ \u@\h:\[\e[1;36m\] $(_dir_chomp "$(pwd)" 20 )$(__git_ps1 " (%s)") : \[\e[1;31m\]\t ] \[\e[0m\]$ '
export JAVA_HOME=/opt/jdk
export PATH=$JAVA_HOME/bin:$PATH
export HISTSIZE=5000
export HISTFILESIZE=5000
export HISTCONTROL=ignoredups
export PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log; fi'

#-------------------------------------------------------------
# Start Personal .bashrc stuff
# if not running interactively, don't do anything
#-------------------------------------------------------------
if [ -z "$PS1" ]; then return; fi
case $- in *i*)
#-------------------------------------------------------------
# Source global definitions (if any)
#-------------------------------------------------------------

if [ -f /etc/bashrc ]; then
      . /etc/bashrc   # --> Read /etc/bashrc, if present.
fi

if [ -f /etc/bash_completion ]; then
 . /etc/bash_completion
fi

# Smart cd corrects for some mispelling
shopt -s cdspell

alias dev='cd /other/workspace'
alias nrv='cd /other/workspace/nrv'
alias nexus='cd /other/workspace/nexus'

# SSH 115
alias ssh115='ssh vecna@qcbot115.rls.vecna.com'

# Make Projects Shortcuts
alias mvnnt="mvn clean install -DskipTests"
alias mknrv="cd /other/workspace/nrv && mvn clean install"
alias mknrvnt="cd /other/workspace/nrv && mvnnt"
alias mknex="cd /other/workspace/nexus && mvn clean install"
alias mknexnt="cd /other/workspace/nexus && mvnnt"
alias mkvrosr="roscd && catkin_make -DCMAKE_BUILD_TYPE=Release && cd -"
alias mkvrosrd="roscd && catkin_make -DCMAKE_BUILD_TYPE=RelWithDebInfo && cd -"
alias mkvrosd="roscd && catkin_make -DCMAKE_BUILD_TYPE=Debug && cd -"
alias mkvros="roscd && catkin_make && cd -"

function alert-on-message() {
  read a || exit;
  now=$(date +"%T");
  echo "$now : Robot Alert!";
  zenity --warning --text "[ $now ]: Robot In Need of Help!";
  alert-on-message;
}

alias robot_alerts="ssh vecna@jagermech 'export ROS_MASTER_URI=http://localhost:11311; export TELEOPERATOR=ALEX_SHER; rostopic echo /alert_cmd' | grep --line-buffered sound | alert-on-message"

function rob_alert() {
  ssh vecna@jagermech 'export ROS_MASTER_URI=http://localhost:11311; export TELEOPERATOR=ALEX_SHER; rostopic echo /alert_cmd' &

  SERV_PID=`ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no vecna@jagermech ps aux | grep 'rostopic echo' | grep ALEX_SHER | awk '{print $2}'`
  echo $SERV_PID
}

# Source bash functions and aliases
source ~/.bash_aliases
source ~/.bash_functions
handle_dev_environment;
alias_completion;

# Handle OROCOS_TAGET Based on Kernel
kver=$(uname -r)
if [ $kver='3.2.0-61-generic' ] ; then
    export OROCOS_TARGET=gnulinux
else
    export OROCOS_TARGET=xenomai
    # Xenomai Exports
    export LD_LIBRARY_FLAGS=$LD_LIBRARY_FLAGS:/usr/xenomai/lib
    export PATH=$PATH:/usr/xenomai/bin/
    export XENOMAI_ROOT_DIR=/usr/xenomai
fi
#if [ -x "/usr/local/bin/fish" ]; then fish; fi
esac;
