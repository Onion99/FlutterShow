
/*
* 抽象类通常用来定义接口，以及部分实现
* */
abstract class UniversalPlatform{
  static bool get  isWeb => ;
}

/*
* 枚举类型也称为 enumerations 或 enums ， 是一种特殊的类，用于表示数量固定的常量值
* 1. 使用枚举的 values 常量， 获取所有枚举值列表（ list ）
* 2. 枚举不能被子类化，混合或实现。
* 3. 枚举不能被显式实例化。
* */
enum UniversalPlatformType{
  Web,
  Windows,
  Linux,
  MacOS,
  Android,
  IOS
}