## Начало работы

```bash
docker-compose up -d
```

## Восстановление БД

**1. Восстановление файлов приложения:**
```bash
# Остановить приложение
docker stop wiki-app

# Расшифровать и распаковать в том
openssl enc -aes-256-cbc -d -pbkdf2 -in "wiki_app_backup.enc" -k "wiki" | \
  sudo tar xzf - -C /var/lib/docker/volumes/wiki_wiki-app-data/_data

# Запустить приложение без бд
docker start wiki-app
```

**2. Восстановление базы данных:**
```bash
openssl enc -aes-256-cbc -d -pbkdf2 -in "wiki_db_backup.enc" -k "wiki" | \
  gunzip | \
  docker exec -i wiki-db psql -U wikijs -d wiki
```
## Если то что описано выше не помогло, в репозитории лежат експортированные volumes из docker desktop воспользуйся ими для восстановления

### Команда, которой были сжата и зашифрованна бд: Дамп -> Сжатие -> Шифрование
docker exec -t wiki-db pg_dump -U wikijs -d wiki | gzip | \
  openssl enc -aes-256-cbc -salt -pbkdf2 -out "wiki_backup_1.sql.gz.enc" -k "wiki"
