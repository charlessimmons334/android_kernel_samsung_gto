#!/bin/bash
DEFCONFIG="arch/arm64/configs/P81081_msm8937_defconfig"

sed -i 's/CONFIG_DEBUG_INFO=y/# CONFIG_DEBUG_INFO is not set/' "$DEFCONFIG"
sed -i 's/CONFIG_SCHED_DEBUG=y/# CONFIG_SCHED_DEBUG is not set/' "$DEFCONFIG"
sed -i 's/CONFIG_MAGIC_SYSRQ=y/# CONFIG_MAGIC_SYSRQ is not set/' "$DEFCONFIG"

grep -q CONFIG_CPU_FREQ_GOV_PERFORMANCE "$DEFCONFIG" || echo "CONFIG_CPU_FREQ_GOV_PERFORMANCE=y" >> "$DEFCONFIG"
grep -q CONFIG_ZRAM "$DEFCONFIG" || echo "CONFIG_ZRAM=y" >> "$DEFCONFIG"

sed -i 's/CONFIG_IOSCHED_DEADLINE=y/# CONFIG_IOSCHED_DEADLINE is not set/' "$DEFCONFIG"

echo "✅ Defconfig patched for performance."