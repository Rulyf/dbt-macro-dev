import pandas

def model(dbt, session):
    dbt.config(
        submission_method = "cluster",
        dataproc_cluster_name = "dbt-python-cluster",
        dataproc_region = "us-east1",
        materialized = 'table',
        packages = ['pandas'],
        schema = 'python_models'
    )
    
    df = dbt.ref('dim_customers')
    
    return df