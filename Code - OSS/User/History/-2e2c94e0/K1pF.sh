#!/bin/bash

busName=com.qq.weixin.uos.whatever
busDir="${XDG_RUNTIME_DIR}/app/${busName}"

# 新增沙盒模式配置函数
function setSandboxMode() {
    local sandbox_config="${XDG_DATA_HOME}/WeChat_Data/options/sandbox_mode"
    if [ ! -f "${sandbox_config}" ]; then
        if [[ "${LANG}" =~ 'zh_CN' ]]; then
            zenity --title "沙盒模式设置" --icon=security-high-symbolic --list --radiolist \
                --column "选择" --column "模式" --column "描述" \
                TRUE "严格" "最高安全性：限制所有系统访问" \
                FALSE "标准" "平衡安全性和功能" \
                FALSE "宽松" "允许更多系统访问" \
                --width=500 --height=200
        else
            zenity --title "Sandbox Mode Settings" --icon=security-high-symbolic --list --radiolist \
                --column "Select" --column "Mode" --column "Description" \
                TRUE "Strict" "Highest security: restrict all system access" \
                FALSE "Standard" "Balance between security and functionality" \
                FALSE "Relaxed" "Allow more system access" \
                --width=500 --height=200
        fi
        case $? in
            0)
                local selected_mode=$(echo $?)
                echo "${selected_mode}" > "${sandbox_config}"
                ;;
            1)
                echo "standard" > "${sandbox_config}"
                ;;
            *)
                echo "standard" > "${sandbox_config}"
                ;;
        esac
    fi
    export SANDBOX_MODE=$(cat "${sandbox_config}")
}

function moeDect() {
    if [[ -f /usr/share/moeOS-Docs/os-release ]]; then
        osRel="/usr/share/moeOS-Docs/os-release"
    else
        osRel="/usr/lib/os-release"
    fi
}

function sourceXDG() {
    if [[ ! ${XDG_CONFIG_HOME} ]]; then
        export XDG_CONFIG_HOME="${HOME}"/.config
        echo "[Info] Guessing XDG Config Home @ ${XDG_CONFIG_HOME}"
    else
        source "${XDG_CONFIG_HOME}"/user-dirs.dirs
        echo "[Info] XDG Config Home defined @ ${XDG_CONFIG_HOME}"
    fi
    if [[ ! ${XDG_DATA_HOME} ]]; then
        export XDG_DATA_HOME="${HOME}"/.local/share
    fi
    export XDG_DOCUMENTS_DIR="$(xdg-user-dir DOCUMENTS)"
}

function manageDirs() {
    if [ -d "${HOME}/Documents/TrashBox" ]; then
        echo "[Warn] Old user data may be present, check ${HOME}/Documents/TrashBox"
    fi
    if [ -d "${XDG_DOCUMENTS_DIR}/WeChat_Data/文档" ]; then
        mv "${XDG_DOCUMENTS_DIR}/WeChat_Data/文档" \
            "${XDG_DOCUMENTS_DIR}/WeChat_Data/Documents"
    fi
    if [ -d "${XDG_DOCUMENTS_DIR}"/WeChat_Data ]; then
        echo "[Info] Migrating user data..."
        mv "${XDG_DOCUMENTS_DIR}"/WeChat_Data "${XDG_DATA_HOME}"/WeChat_Data
    fi
    if [ -L "${XDG_DOCUMENTS_DIR}"/xwechat_files ]; then
        echo "[Info] Removing unused links..."
        rm "${XDG_DOCUMENTS_DIR}"/xwechat_files
    fi
    createWrapIfNotExist "${XDG_DATA_HOME}"/WeChat_Data
}

function detectXauth() {
    if [ ! ${XAUTHORITY} ]; then
        echo '[Warn] No ${XAUTHORITY} detected! Do you have any X server running?'
        export XAUTHORITYpath="/$(uuidgen)/$(uuidgen)"
        xhost +
    else
        export XAUTHORITYpath="${XAUTHORITY}"
    fi
    if [[ ! ${DISPLAY} ]]; then
        echo '[Warn] No ${DISPLAY} detected! Do you have any X server running?'
    fi
}

function createWrapIfNotExist() {
    if [ -d "$@" ]; then
        return 0
    else
        mkdir -p "$@"
    fi
}

function inputMethod() {
    if [[ ${XMODIFIERS} =~ fcitx ]] || [[ ${QT_IM_MODULE} =~ fcitx ]] || [[ ${GTK_IM_MODULE} =~ fcitx ]]; then
        export QT_IM_MODULE=fcitx
        export GTK_IM_MODULE=fcitx
    elif [[ ${XMODIFIERS} =~ ibus ]] || [[ ${QT_IM_MODULE} =~ ibus ]] || [[ ${GTK_IM_MODULE} =~ ibus ]]; then
        export QT_IM_MODULE=ibus
        export GTK_IM_MODULE=ibus
        IBUS_USE_PORTAL=1
    elif [[ ${XMODIFIERS} =~ gcin ]]; then
        export QT_IM_MODULE=ibus
        export GTK_IM_MODULE=gcin
        export LC_CTYPE=zh_TW.UTF-8
    else
        echo '[Warn] Input Method potentially broken! Please set $XMODIFIERS properly'
    fi
}

function importEnv() {
    if [ -e "${XDG_DATA_HOME}"/WeChat_Data/wechat.env ]; then
        echo "[Info] ${XDG_DATA_HOME}/WeChat_Data/wechat.env exists"
    else
        touch "${XDG_DATA_HOME}"/WeChat_Data/wechat.env
    fi
    if [[ $(cat "${XDG_DATA_HOME}"/WeChat_Data/wechat.env) ]]; then
        return 0
    else
        echo "# Envs" >>"${XDG_DATA_HOME}"/WeChat_Data/wechat.env
        echo "isWeChatEnvPresent=1" >>"${XDG_DATA_HOME}"/WeChat_Data/wechat.env
    fi
}

function cameraDect() {
    bwCamPar=""
    for camera in $(ls /dev/video*); do
        if [ -e ${camera} ]; then
            bwCamPar="${bwCamPar} --dev-bind ${camera} ${camera}"
        fi
    done
}

# 修改execApp函数，增加沙盒模式支持
function execApp() {
    # 根据沙盒模式设置不同的安全策略
    local sandbox_params=""
    case "${SANDBOX_MODE}" in
        "strict")
            sandbox_params="--new-session --die-with-parent --unshare-all --share-net"
            ;;
        "standard")
            sandbox_params="--unshare-user --unshare-pid --unshare-uts --unshare-ipc"
            ;;
        "relaxed")
            sandbox_params="--unshare-user"
            ;;
        *)
            sandbox_params="--unshare-user --unshare-pid --unshare-uts --unshare-ipc"
            ;;
    esac

    if [ -f /usr/lib/wechat/keyBlocker.so ]; then
        if [ ! ${LD_PRELOAD} ]; then
            echo "[Info] Key blocker enabled"
            LD_PRELOAD=/usr/lib/wechat/keyBlocker.so
        else
            echo "[Info] Key blocker enabled, appending LD_PRELOAD"
            LD_PRELOAD="/usr/lib/wechat/keyBlocker.so:${LD_PRELOAD}"
        fi
    else
        LD_PRELOAD=""
    fi
    
    if [[ ${wechatXserverPatch} = 1 ]]; then
        xhost +
    fi
    
    if [[ $(fc-match emoji) =~ Twemoji ]]; then
        echo "[Info] Emoji already set to Twemoji"
    else
        if [ -f /usr/share/fontconfig/conf.avail/75-twemoji.conf ]; then
            cp /usr/share/fontconfig/conf.avail/75-twemoji.conf \
                "${XDG_CONFIG_HOME}"/fontconfig
            echo "[Info] Using Twemoji as Emoji font, fontconfig has been changed"
        else
            echo "[Warn] Emojis may be broken"
        fi
    fi
    
    if [ ! -S "${busDir}/bus" ]; then
        echo "[Info] Waiting for D-Bus proxy..."
        counter=0
        while [ ! -S "${busDir}/bus" ]; do
            counter=$(expr ${counter} + 1)
            sleep 0.1s
        done
        echo "[Info] D-Bus proxy took $(expr ${counter} / 10)s to launch"
    fi
    
    cameraDect
    importEnv
    
    if [ ${XDG_SESSION_TYPE} = wayland ]; then
        echo "[Info] Skipping Xhost operation"
    else
        xhost + #Unlock the XServer for X11 users
    fi
    
    if [ ! ${unitName} ]; then
        unitName="wechat"
    fi
    
    mkdir -p "${XDG_DATA_HOME}"/WeChat_Data/.config
    createWrapIfNotExist "${XDG_DOCUMENTS_DIR}"/WeChat
    
    echo "GTK_IM_MODULE is ${GTK_IM_MODULE}"
    echo "QT_IM_MODULE is ${QT_IM_MODULE}"
    echo "Sandbox Mode: ${SANDBOX_MODE}"
    
    if [ ! ${bwBindPar} ]; then
        bwBindPar="/$(uuidgen)"
    fi
    echo "bwBindPar is ${bwBindPar}"
    
    systemd-run \
    --user \
    ${sdOption} \
    -p SyslogIdentifier=WeChat \
    -p Environment=LD_PRELOAD="${LD_PRELOAD}" \
    -u "${unitName}" \
    -p Description="WeChat" \
    -p Documentation="https://wiki.archlinuxcn.org/wiki/%E5%BE%AE%E4%BF%A1#%E5%BE%AE%E4%BF%A1_Linux_%E5%8E%9F%E7%94%9F%E7%89%88%E9%87%8D%E6%9E%84" \
    -p ExitType=cgroup \
    -p OOMPolicy=stop \
    -p OOMScoreAdjust=100 \
    -p KillMode=control-group \
    -p CPUAccounting=yes \
    -p StartupCPUWeight=idle \
    -p CPUSchedulingPriority=1 \
    -p CPUSchedulingPolicy=idle \
    -p Nice=19 \
    -p StartupIOWeight=1 \
    -p MemoryMax=90% \
    -p MemoryHigh=80% \
    -p LimitCORE=0 \
    -p CPUWeight=20 \
    -p IOWeight=20 \
    -p ManagedOOMSwap=kill \
    -p ManagedOOMMemoryPressure=kill \
    -p IPAccounting=yes \
    -p UnsetEnvironment=XDG_CURRENT_DESKTOP \
    -p PrivateIPC=yes \
    -p DevicePolicy=strict \
    -p EnvironmentFile=/usr/lib/wechat/envs \
    -p EnvironmentFile="${XDG_DATA_HOME}"/WeChat_Data/wechat.env \
    -p Environment=GTK_IM_MODULE="${GTK_IM_MODULE}" \
    -p Environment=QT_IM_MODULE="${QT_IM_MODULE}" \
    -p IPAddressDeny=localhost \
    -p IPAddressDeny=link-local \
    -p IPAddressDeny=multicast \
    -p SystemCallFilter=~@clock \
    -p SystemCallFilter=~@cpu-emulation \
    -p SystemCallFilter=~@debug \
    -p SystemCallFilter=~@module \
    -p SystemCallFilter=~@obsolete \
    -p SystemCallFilter=~@raw-io \
    -p SystemCallFilter=~@reboot \
    -p SystemCallFilter=~@swap \
    -p SystemCallErrorNumber=EPERM \
    -p ProcSubset=pid \
    -p RestrictAddressFamilies=AF_UNIX \
    -p RestrictAddressFamilies=AF_INET \
    -p RestrictAddressFamilies=AF_INET6 \
    -p NoNewPrivileges=yes \
    -p RestrictNamespaces=~net \
    -p RestrictNamespaces=~pid \
    -p RestrictNamespaces=~uts \
    -p RestrictNamespaces=~ipc \
    -p ProtectControlGroups=yes \
    -p KeyringMode=private \
    -p ProtectClock=yes \
    -p CapabilityBoundingSet= \
    -p ProtectKernelModules=yes \
    -p SystemCallArchitectures=native \
    -p RestrictNamespaces=no \
    -p RestrictSUIDSGID=yes \
    -p LockPersonality=yes \
    -p RestrictRealtime=yes \
    -p ProtectSystem=strict \
    -p ProtectProc=invisible \
    -p ProtectHome=no \
    -p PrivateUsers=yes \
    -p UMask=077 \
    -p TimeoutStopSec=20s \
    -p RestrictAddressFamilies=~AF_PACKET \
    -p PrivateTmp=yes \
    -p BindReadOnlyPaths=/usr/bin/true:/usr/bin/lsblk \
    -p BindReadOnlyPaths=/dev/null:/proc/cpuinfo \
    -p BindReadOnlyPaths=/dev/null:/proc/meminfo \
    -p BindReadOnlyPaths=/opt/wechat/files:/usr/lib/license \
    -p BindReadOnlyPaths=-/run/systemd/resolve/stub-resolv.conf \
    -p BindReadOnlyPaths=/usr/share/wechat/license/etc/os-release:"${osRel}" \
    -p BindReadOnlyPaths=/usr/lib/wechat/flatpak-info:"${XDG_RUNTIME_DIR}/.flatpak-info" \
    -p Environment=PATH=/sandbox:"${PATH}" \
    -- \
    bwrap \
        ${sandbox_params} \
        --tmpfs /tmp \
        --ro-bind-try /tmp/.X11-unix /tmp/.X11-unix \
        --dev /dev \
        --dev-bind /dev/dri /dev/dri \
        --dev-bind-try /dev/nvidia0 /dev/nvidia0 \
        --dev-bind-try /dev/nvidiactl /dev/nvidiactl \
        --dev-bind-try /dev/nvidia-modeset /dev/nvidia-modeset \
        --dev-bind-try /dev/nvidia-uvm /dev/nvidia-uvm \
        --tmpfs /sys \
        --bind /sys/module/ /sys/module/ \
        --ro-bind /sys/dev/char /sys/dev/char \
        --ro-bind /sys/devices /sys/devices \
        --dir /sandbox \
        --ro-bind /usr/lib/flatpak-xdg-utils/xdg-open \
            /sandbox/chromium \
        --ro-bind /usr/lib/flatpak-xdg-utils/xdg-open \
            /sandbox/firefox \
        --ro-bind /usr/lib/wechat/mimeapps.list \
            "${XDG_DATA_HOME}"/WeChat_Data/.config/mimeapps.list \
        --proc /proc \
        --bind /usr /usr \
        --ro-bind /etc /etc \
        --ro-bind-try /lib /lib \
        --ro-bind-try /lib64 /lib64 \
        --ro-bind-try /bin /bin \
        --ro-bind-try /sbin /sbin \
        --ro-bind-try /opt /opt \
        --bind "${busDir}/bus" "${XDG_RUNTIME_DIR}/bus" \
        --ro-bind "${XDG_RUNTIME_DIR}/pulse" \
            "${XDG_RUNTIME_DIR}/pulse" \
        --bind "${XDG_DATA_HOME}"/WeChat_Data "${HOME}" \
        --ro-bind-try "${XDG_DATA_HOME}"/icons "${XDG_DATA_HOME}"/icons \
        --dir "${XDG_DATA_HOME}/WeChat_Data/Shared Directory" \
        --dir "${HOME}/共享目录" \
        --dir "${XDG_DOCUMENTS_DIR}/WeChat" \
        --bind "${XDG_DOCUMENTS_DIR}/WeChat" \
            "${HOME}/共享目录" \
        --bind "${XDG_DOCUMENTS_DIR}"/WeChat \
            "${HOME}/Shared Directory" \
        --ro-bind-try "${XAUTHORITYpath}" "${XAUTHORITYpath}" \
        --ro-bind-try "${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY}" \
                "${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY}" \
        --ro-bind-try "${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY}.lock" \
                "${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY}.lock" \
        --ro-bind /usr/lib/wechat/open \
            /sandbox/dde-file-manager \
        --ro-bind /usr/lib/wechat/open \
            /sandbox/xdg-open \
        --ro-bind /usr/lib/wechat/open \
            /sandbox/open \
        --ro-bind /usr/share/wechat/license/var/ /var/ \
        --ro-bind /usr/share/wechat/license/etc/lsb-release \
            /etc/lsb-release \
        --ro-bind /usr/lib/wechat/user-dirs.dirs \
            "${XDG_CONFIG_HOME}"/user-dirs.dirs \
        --ro-bind-try "${XDG_CONFIG_HOME}"/fontconfig \
            "${XDG_CONFIG_HOME}"/fontconfig \
        --ro-bind-try "${XDG_DATA_HOME}/fonts" \
            "${XDG_DATA_HOME}/fonts" \
        --ro-bind-try "/run/systemd/resolve/stub-resolv.conf" \
            "/run/systemd/resolve/stub-resolv.conf" \
        --dir "${XDG_DATA_HOME}/WeChat_Data/Documents" \
        --bind "${XDG_DATA_HOME}/WeChat_Data" \
            "${XDG_DATA_HOME}/WeChat_Data" \
        --tmpfs "${XDG_DATA_HOME}/WeChat_Data"/options \
        --ro-bind-try /dev/null "${XDG_DATA_HOME}"/WeChat_Data/wechat.env \
        --bind-try "${bwBindPar}" "${bwBindPar}" \
        ${bwCamPar} \
        --setenv XDG_DOCUMENTS_DIR "$HOME/Documents" \
        --setenv XDG_DATA_HOME "${XDG_DATA_HOME}" \
        --unshare-cgroup-try \
        --unshare-ipc \
        --unshare-uts \
        --unshare-user \
        --disable-userns \
        -- \
            "${launchTarget}"
    if [[ $? = 0 ]]; then
        echo '[Info] To view logs, launch this script with "--actions connect-tty" or type "journalctl --user -eu wechat"'
    fi
}

function execAppUnsafe() {
    source /usr/lib/wechat/envs
    source "${XDG_DATA_HOME}"/WeChat_Data/wechat.env
    echo "GTK_IM_MODULE is ${GTK_IM_MODULE}"
    echo "QT_IM_MODULE is ${QT_IM_MODULE}"
    bwrap \
        --dev-bind / / \
        --bind /opt/wechat/files \
            /usr/lib/license \
        --ro-bind /usr/share/wechat/license/var/ \
            /var/ \
        --ro-bind /usr/share/wechat/license/etc/os-release \
            "${osRel}" \
        --ro-bind /usr/share/wechat/license/etc/lsb-release \
            /etc/lsb-release \
        --setenv QT_QPA_PLATFORM xcb \
        --setenv LD_LIBRARY_PATH /opt/wechat/files:/usr/lib/wechat/so:/usr/lib/wechat/so \
        --setenv QT_AUTO_SCREEN_SCALE_FACTOR 1 \
        --setenv PATH /sandbox:"${PATH}" \
        --setenv QT_PLUGIN_PATH "/usr/lib/qt/plugins /opt/wechat/files/wechat" \
        "${launchTarget}"
}

function questionFirstLaunch() {
    if [ ! -f "${XDG_DATA_HOME}"/WeChat_Data/options/sandbox ]; then
        setSandboxMode
        return 0
    fi
}

function disableSandbox() {
    if [[ $@ =~ "f5aaebc6-0014-4d30-beba-72bce57e0650" ]] && [[ $@ =~ "--actions" ]]; then
        rm "${XDG_DATA_HOME}"/WeChat_Data/options/sandbox
        questionFirstLaunch
    fi
}

function openDataDir() {
    if [[ $@ =~ "--actions" ]] && [[ $@ =~ "opendir" ]]; then
        xdg-open "${XDG_DATA_HOME}"/WeChat_Data
        exit $?
    fi
    if [[ $@ =~ "--actions" ]] && [[ $@ =~ "shareddir" ]]; then
        mkdir -p "${XDG_DOCUMENTS_DIR}"/WeChat
        xdg-open "${XDG_DOCUMENTS_DIR}"/WeChat
        exit $?
    fi
}

function launch() {
    detectXauth
    inputMethod
    moeDect
    if [[ $(systemctl --user is-failed wechat.service) = failed ]]; then
        echo "[Warning] WeChat failed last time"
        systemctl --user reset-failed wechat.service
    fi
    if [[ $(systemctl --user is-active wechat.service) = active ]]; then
        warnMulRunning wechat.service
    fi
    if [[ ! ${launchTarget} ]]; then
        if [[ $@ =~ "--actions" ]] && [[ $@ =~ "debug-shell" ]]; then
            launchTarget="/usr/bin/bash"
        else
            launchTarget="/opt/wechat/files/wechat"
        fi
    fi
    if [[ $@ =~ "--actions" ]] && [[ $@ =~ "connect-tty" ]]; then
        sdOption="-t"
    elif [[ $@ =~ "--actions" ]] && [[ $@ =~ "pipe-tty" ]]; then
        sdOption="-P"
    else
        sdOption=""
    fi
    if [[ ${trashAppUnsafe} = 1 ]]; then
        echo "Launching WeChat UOS (unsafe)..."
        execAppUnsafe
    else
        dbusProxy
        echo "Launching WeChat UOS..."
        execApp
    fi
}

function stopApp() {
    stopCmd="systemctl --user stop wechat-dbus-proxy wechat"
    timeSpent=$( { time ${stopCmd}; } 2>&1 \
        | grep real \
        | awk \
        '/real/ {split($2, a, "m"); split(a[2], b, "s"); print a[1] * 60 + b[1]}')
    if (( $(echo "${timeSpent} > 2" | bc -l) )); then
        echo "[Warn] WeChat took ${timeSpent}s to stop! Is the system too slow or WeChat screwed?"
        if (( $(echo "${timeSpent} > 20" | bc -l) )); then
            notify-send \
            -i wechat \
            -u normal \
            -t 5 \
            "WeChat" "WeChat is forcibly stopped"
        fi
    fi
}

if [[ $@ = "--actions quit" ]]; then
    stopApp $@
    exit $?
fi

sourceXDG
disableSandbox $@
questionFirstLaunch
openDataDir $@
manageDirs
launch $@
