#Generate .pb.go files based on .proto files
START=$(pwd)

protoc:
	protoc -I pb/v1/ \
      --go_out=plugins=grpc:pb \
	  --gogrpcmock_out=:pb \
	  pb/v1/*.proto

install:
	go get -u \
		github.com/golang/protobuf/proto \
		github.com/golang/protobuf/protoc-gen-go \
		google.golang.org/grpc \
		github.com/gogo/protobuf/protoc-gen-gogoslick \
		github.com/gogo/protobuf/gogoproto \
		github.com/DATA-DOG/go-sqlmock \
		github.com/onsi/ginkgo/ginkgo \
		github.com/onsi/gomega/... \
		github.com/SafetyCulture/s12-proto/protobuf/protoc-gen-gogrpcmock \
		golang.org/x/crypto/bcrypt
	go install github.com/SafetyCulture/s12-proto/protobuf/protoc-gen-gogrpcmock
	go get -tags 'mysql' -u github.com/golang-migrate/migrate/cmd/migrate
	go get gopkg.in/go-playground/validator.v9

clean:
	rm ./pb/**/*.pb.go

test:
	ginkgo -r -failFast