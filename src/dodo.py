from typing import Tuple, Dict, Union

bandit: str = 'bandit -r . --exclude tests'
safety: str = 'safety check -i 46499'

sqlfluff = 'sqlfluff lint -vv $(find /src -type f -name "*.sql")'
sqlfix = 'sqlfluff fix -f -vv $(find /src -type f -name "*.sql")'

outdated = 'pip list --outdated --format=columns'

default_verbosity = 2


def metadata_from(actions: Tuple[str, ...]) -> Dict[str, Union[Tuple, int]]:
    return {
        'actions': actions, 'verbosity': default_verbosity,
    }


def task_bandit() -> Dict[str, Union[Tuple, int]]:
    return metadata_from(actions=(bandit,))


def task_safety() -> Dict[str, Union[Tuple, int]]:
    return metadata_from(actions=(safety,))


def task_outdated() -> Dict[str, Union[Tuple, int]]:
    return metadata_from(actions=(outdated,))


def task_sqlfluff() -> Dict[str, Union[Tuple, int]]:
    return metadata_from(actions=(sqlfluff,))


def task_sqlfix() -> Dict[str, Union[Tuple, int]]:
    return metadata_from(actions=(sqlfix,))


def task_lint() -> Dict[str, Union[Tuple, int]]:
    return metadata_from(
        actions=(sqlfluff, bandit, safety,),
    )


def task_all() -> Dict[str, Union[Tuple, int]]:
    return metadata_from(
        actions=(bandit, safety, outdated,),
    )
