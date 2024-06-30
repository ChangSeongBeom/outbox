## 개요

- outbox는 흔히 MSA환경에서 동기화된 데이터를 어떻게 효율적으로 관리할지에 착안하여 만들었음.
- outbox는 타 테이블간 outbox라는 공통 테이블을 두어 outbox테이블에 insert및 update되는순간 이를 카프카 등 큐에 날림.

- 또한 outbox를 통해 타 msa서비스들간 outbox테이블에 데이터가 변경될시 한곳으로 토픽으로 모아주게 설계하였음.

- outbox는 데이터의 정합성을 유지시킬수 있지만, 무엇보다 outbox transactional pattern을 활용하면, MSA의 보상 정책에 대한 고민을 조금 덜해도됨.
