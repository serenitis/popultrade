package com.popultrade.webapp;

import java.sql.Types;

import org.hibernate.dialect.PostgreSQL82Dialect;
import org.hibernate.type.descriptor.sql.BinaryTypeDescriptor;
import org.hibernate.type.descriptor.sql.SqlTypeDescriptor;
//import org.hibernate.dialect.PostgreSQLDialect;;

public class PostgreSQLDialectCustom extends  PostgreSQL82Dialect {

    @Override
    public SqlTypeDescriptor remapSqlTypeDescriptor(SqlTypeDescriptor sqlTypeDescriptor) {
    if (sqlTypeDescriptor.getSqlType() == java.sql.Types.BLOB) {
    	
      return BinaryTypeDescriptor.INSTANCE;
    }
    return super.remapSqlTypeDescriptor(sqlTypeDescriptor);
  }
}
 