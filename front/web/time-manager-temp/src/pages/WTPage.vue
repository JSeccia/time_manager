<template>
    <div>
        <WTComponent />
    </div>
</template>


<script>

import { defineComponent } from 'vue';
import WTComponent from 'src/components/WTComponent.vue';

export default defineComponent({
    name: 'WTPage',

    components: {
        WTComponent,
    },
});

</script>