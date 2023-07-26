target=$1
debug=${2:-"release"}
fast=${3:-"fast"}

set -e

source ../../local_scripts/identify_target.sh $target $debug $fast

# tool to build
tool="I2LM"

# decrypt source files if necessary
if [ ! -d int2lm ] && [ -f int2lm.patch ]; then
    ../../patch/merge_patch.sh cclm-sp_2.0/src/int2lm int2lm.patch int2lm
elif [ ! -d int2lm ]; then
    echo "No valid int2lm directory could be found. Abort."
    exit
fi

# decrypt source files if necessary
if [ ! -d utils ] && [ -f utils.patch ]; then
    ../../patch/merge_patch.sh cclm-sp_2.0/src/utils utils.patch utils
elif [ ! -d utils ]; then
    echo "No valid int2lm directory could be found. Abort."
    exit
fi

# create tool's directory (if not existing)
echo ssh -t "${user_at_dest}" "mkdir -p ${dest_folder}/tools/${tool}"
ssh -t "${user_at_dest}" "mkdir -p ${dest_folder}/tools/${tool}"

# deploy the code from local source
echo rsync -r -i -u int2lm ${dest}/tools/${tool}/.
echo rsync -r -i -u utils ${dest}/tools/${tool}/.
echo rsync -i -u start_build_${target}.sh ${dest}/tools/${tool}/
echo rsync -i -u build_${target}.sh ${dest}/tools/${tool}/

rsync -r -i -u int2lm ${dest}/tools/${tool}/.
rsync -r -i -u utils ${dest}/tools/${tool}/.
rsync -i -u start_build_${target}.sh ${dest}/tools/${tool}/
rsync -i -u build_${target}.sh ${dest}/tools/${tool}/

# start the build process
echo ssh -t "${user_at_dest}" "cd ${dest_folder}/tools/${tool}/; bash -c \"source ~/.bash_profile; source start_build_${target}.sh $debug $fast\""
ssh -t "${user_at_dest}" "cd ${dest_folder}/tools/${tool}/; bash -c \"source ~/.bash_profile; source start_build_${target}.sh $debug $fast\""

../../local_scripts/tag_build.sh "${target_keyword}" "$debug" "$fast" "$tool"
