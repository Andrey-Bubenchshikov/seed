from sys import argv


def is_dbt_file(filename: str) -> bool:
    dbt_extensions = ('.sql', '.yml')
    return any(
        dbt_extension in filename for dbt_extension in dbt_extensions
    )


def has_less_than_n_changes() -> bool:
    n = 4
    filenames = argv
    dbt_filenames = [
        filename for filename in filenames if is_dbt_file(
            filename=filename,
        )
    ]
    amount = len(dbt_filenames)
    if amount > n:
        print(f'{amount} exceeds permitted {n} files changed since dev')
        return False
    return True


if __name__ == '__main__':
    if not has_less_than_n_changes():
        raise ValueError
    exit(0)
