YELLOW='\033[1;33m'
NC='\033[0m'

# project_name="$1"
# feature_name="$2"

# [ ! -f mason.yaml ] && echo "No mason.yaml. Please run mason init" && exit 1
# [ ! -f mason-lock.json ] && echo "No mason-lock.json. Please run mason get" && exit 1

project_name=`basename $(pwd)`
# printf "${YELLOW}What is the project name? > ${NC}"
# read project_name
printf "${YELLOW}What is the feature name? > ${NC}"
read feature_name
printf "${YELLOW}What is the entity name? > ${NC}"
read entity

echo "Setup your entity:"
mason make entity --feature_name $feature_name --model_name $entity
echo "Setup your respone/request model:"
mason make model --feature_name $feature_name
echo "Setup your repository:"
mason make repository --feature_name $feature_name --project_name $project_name
echo "Setup your notifier:"
mason make notifier --feature_name $feature_name --project_name $project_name --entity $entity
