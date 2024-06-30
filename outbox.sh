# 최종 가안
# outbox 패턴+ unwrap을 활용한 전송 + regrex를 활용한 SMT라우팅
#결과
#lms +cms 통합
{"id":"da36b216-1994-4955-99d0-8ac7bb4b27a7","aggregate_id":"257babc1-5021-4212-be82-d55a573ae411","aggregate_name":"Video","created_on":1715534210630068,"event_name":"VideoSaveReqDTO","payload":"{\n  \"contentName\" : \"testContent\",\n  \"contentTypeCode\" : \"VIDEO\",\n  \"channelNo\" : 1,\n  \"delYn\" : \"N\",\n  \"openYn\" : \"Y\",\n  \"fileNo\" : 1\n}","event_type":"I","__op":"c","__source_ts_ms":1715501810000}
{"id":"4d700ec0-81ef-4479-89f1-5235a77e6573","aggregate_id":"e9360d75-f446-4656-b00c-e1dd4532e3f2","aggregate_name":"Course","created_on":1715534215994065,"event_name":"OnlineCourseSaveReqDTO","event_type":"I","payload":"{\n  \"courseName\" : \"sadf\",\n  \"channelNo\" : 1\n}","__op":"c","__source_ts_ms":1715501815000}
{"id":"1e6204d2-5f1f-4e2a-ad9c-d2ef172a85df","aggregate_id":"98969db1-6418-4c09-bddf-fbaa7d3f992f","aggregate_name":"Video","created_on":1715534291839689,"event_name":"VideoSaveReqDTO","payload":"{\n  \"contentName\" : \"testContent\",\n  \"contentTypeCode\" : \"VIDEO\",\n  \"channelNo\" : 1,\n  \"delYn\" : \"N\",\n  \"openYn\" : \"Y\",\n  \"fileNo\" : 1\n}","event_type":"I","__op":"c","__source_ts_ms":1715501891000}
{"id":"38ede848-856a-49e6-8327-5233c933bb9b","aggregate_id":"15f18f8e-e04e-435b-91dd-f4be5a033da3","aggregate_name":"Course","created_on":1715534302561688,"event_name":"OnlineCourseSaveReqDTO","event_type":"I","payload":"{\n  \"courseName\" : \"sadf\",\n  \"channelNo\" : 1\n}","__op":"c","__source_ts_ms":1715501902000}

{
    "name": "course-outbox-connector",
    "config": {
        "connector.class": "io.debezium.connector.mysql.MySqlConnector",
        "tasks.max": "1",
        "database.hostname": "localhost",
        "database.port": "3306",
        "database.user": "root",
        "database.password": "1234",
        "database.server.id": "1",
        "database.server.name": "dbserver1",
        "database.include.list": "cms,lms",
        "database.ssl.mode": "disabled",
        "table.include.list": "cms.outbox,lms.outbox",
        "database.history.kafka.bootstrap.servers": "localhost:9092",
        "database.history.kafka.topic": "schema.history.fullfillment",
        "database.allowPublicKeyRetrieval": "true",
        "topic.prefix": "outbox.cdc",
        "transforms": "unwrap,route",
        "transforms.unwrap.type": "io.debezium.transforms.ExtractNewRecordState",
        "transforms.unwrap.add.fields": "op,source.ts_ms",
        "transforms.unwrap.delete.handling.mode": "none",
        "transforms.unwrap.drop.tombstones": "true",
        "transforms.unwrap.add.headers": "eventType:event_type",
        "transforms.route.type": "org.apache.kafka.connect.transforms.RegexRouter",
        "transforms.route.regex": ".*",
        "transforms.route.replacement": "outbox.cdc",
        "key.converter": "org.apache.kafka.connect.json.JsonConverter",
        "value.converter": "org.apache.kafka.connect.json.JsonConverter",
        "key.converter.schemas.enable": "false",
        "value.converter.schemas.enable": "false",
        "schema.history.internal.kafka.bootstrap.servers": "localhost:9092",
        "schema.history.internal.kafka.topic": "schema.history.fullfillment.internal",
        "database.connectionTimeZone": "Asia/Seoul"
    }
}