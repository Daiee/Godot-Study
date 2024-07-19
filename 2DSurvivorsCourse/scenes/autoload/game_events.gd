## 全局加载，单例模式
extends Node
## 1.收集经验瓶信号
## 2.升级增加能力信号
signal experience_vial_collected(number: float)
signal ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary)


## 将发出收集经验瓶信号封装成函数，方便调用
func emit_experience_vial_collected(number: float) -> void:
	experience_vial_collected.emit(number)


## 将发出升级增加能力信号封装成函数，方便调用
func emit_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary) -> void:
	ability_upgrade_added.emit(upgrade, current_upgrades)
