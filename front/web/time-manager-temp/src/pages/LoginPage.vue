<template>
    <p>bzefgfazehfjkazbkjhb</p>
    <div class="q-pa-md">
        <q-layout view="lHh lpr lFf" container style="height: 400px" class="shadow-2 rounded-borders">

            <q-footer elevated>
                <q-toolbar>
                    <q-toolbar-title>Footer</q-toolbar-title>
                </q-toolbar>
            </q-footer>

            <q-page-container>
                <q-page class="q-pa-md">
                    <p v-for="n in 15" :key="n">
                        Lorem ipsum dolor sit amet consectetur adipisicing elit. Fugit nihil praesentium molestias a
                        adipisci, dolore vitae odit, quidem consequatur optio voluptates asperiores pariatur eos numquam
                        rerum delectus commodi perferendis voluptate?
                    </p>
                </q-page>
            </q-page-container>
        </q-layout>
    </div>
</template>

<script>
import { defineComponent, ref } from 'vue'

export default defineComponent({
    name: 'LoginPage',
})
</script>

<style>
.q-card {
    width: 360px;
}
</style>