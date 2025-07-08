import sys 
from openmind_hub import upload_folder,create_repo

folder_path = sys.argv[1]
repo_id = sys.argv[2]

# create_repo(
#     token="",
#     repo_id="",
#     repo_type="model"
# )

upload_folder(
    token="78c535f2d02b7f072f86a0cee82ba05165773484",
    folder_path=folder_path,
    repo_id=repo_id,
)
