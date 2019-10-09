<?php

function adminer_object()
{
    include_once "./plugins/plugin.php";
    foreach (glob("plugins/*.php") as $filename) {
        include_once "./$filename";
    }
    return new AdminerPlugin([
        new AdminerSqlLog,
        new AdminerTablesFilter,
        new AdminerVersionNoverify,
        new AdminerReadableDates,
    ]);
}
include "./adminer.php";

